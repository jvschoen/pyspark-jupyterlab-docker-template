FROM jupyter/pyspark-notebook

USER root

# Add essential packages
RUN apt-get update && apt-get install -y build-essential curl git gnupg2 nano apt-transport-https software-properties-common

# Set locale
RUN apt-get update && apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen


# Make the project directory and copy required files and dirs under it.
RUN mkdir /home/jovyan/project/

###
# These copies below ensure we get our github structure to match
# As well as maintain docker build requirements so we can clone the 
# Git repo locally and build a docker image based on the current state 
# of the repo.
# the Notebooks and data directories will be mounted to local drive
# so any edits to these dirs in the docker image will be live in the local OS 
##

# Move Git Repo to project dir
COPY --chown=$NB_UID:$NB_UID ./.git /home/jovyan/project/.git
COPY --chown=$NB_UID:$NB_UID ./.gitignore /home/jovyan/project/

# Docker Compose Dependent files
COPY --chown=$NB_UID:$NB_UID ./Dockerfile /home/jovyan/project/
COPY --chown=$NB_UID:$NB_UID ./docker-compose.yml.tmpl /home/jovyan/project/
COPY --chown=$NB_UID:$NB_UID ./extras /home/jovyan/project/extras
COPY --chown=$NB_UID:$NB_UID ./setup-compose.sh /home/jovyan/project/

# Analysis Dirs, notebooks and data
COPY --chown=$NB_UID:$NB_UID ./data/ /home/jovyan/project/data
COPY --chown=$NB_UID:$NB_UID ./notebooks /home/jovyan/project/notebooks

# Python requirements.txt
COPY --chown=$NB_UID:$NB_UID ./requirements.txt /home/jovyan/project/

# Custom styling
RUN mkdir -p /home/jovyan/.jupyter/custom
COPY --chown=$NB_UID:$NB_UID extras/custom/custom.css /home/jovyan/.jupyter/custom/

# Add config to Jupyter notebook
COPY --chown=$NB_UID:$NB_UID extras/jupyter/jupyter_notebook_config.py /home/jovyan/.jupyter/

# Copy readme
COPY --chown=$NB_UID:$NB_UID ./README.md /home/joyvan/project/README.md

# Make r/w for all
USER root
RUN chmod -R 777 /home/jovyan/

# Spark libraries
RUN wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar -P $SPARK_HOME/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar -P $SPARK_HOME/jars/

# Download and install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# Cleanup aws cli source 
RUN rm -r ./aws 
RUN rm awscliv2.zip

USER $NB_UID

# Install Python requirements
RUN pip install -r /home/jovyan/project/requirements.txt

# Install NLTK
#RUN python -c "import nltk; nltk.download('popular')"

# NB extensions
# TO be able to use table of contents
RUN pip install --upgrade jupyterlab-git

# These fail
#RUN jupyter lab build
#RUN jupyter labextension enable
#RUN jupyter labextension install @jupyterlab/toc

#RUN jupyter contrib nbextension install --user
#RUN jupyter nbextensions_configurator enable --user

USER root
RUN chmod -R 777 /home/jovyan/

# THis fails
#RUN yes | rm -r /home/jovyan/work

USER $NB_UID

# Run the notebook
#CMD ["/opt/conda/bin/jupyter", "lab", "--allow-root", "--port", "8558"]