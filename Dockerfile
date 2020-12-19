FROM jupyter/pyspark-notebook

USER root
# Add essential packages
RUN apt-get update && apt-get install -y build-essential curl git gnupg2 nano apt-transport-https software-properties-common

# Set locale
RUN apt-get update && apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen

# Add config to Jupyter notebook
COPY extras/jupyter/jupyter_notebook_config.py /home/jovyan/.jupyter/
USER root
RUN chmod -R 777 /home/jovyan/

# Spark libraries
RUN wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar -P $SPARK_HOME/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar -P $SPARK_HOME/jars/

# AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN rm -r ./aws 
RUN rm awscliv2.zip

USER $NB_UID

# Install Python requirements
COPY --chown=$NB_UID:$NB_UID requirements.txt /home/jovyan/
RUN pip install -r /home/jovyan/requirements.txt

# Install NLTK
#RUN python -c "import nltk; nltk.download('popular')"

# Custom styling
RUN mkdir -p /home/jovyan/.jupyter/custom
COPY --chown=$NB_UID:$NB_UID extras/custom/custom.css /home/jovyan/.jupyter/custom/

# NB extensions
# TO be able to use table of contents
RUN pip install --upgrade jupyterlab-git
#RUN jupyter labextension install @jupyterlab/toc
#RUN jupyter contrib nbextension install --user
#RUN jupyter nbextensions_configurator enable --user

COPY --chown=$NB_UID:$NB_UID ./notebooks /home/jovyan/notebooks
COPY --chown=$NB_UID:$NB_UID ./data /home/jovyan/data

RUN echo "converting README"
COPY --chown=$NB_UID:$NB_UID ./extras/README.md /home/joyvan/README.md

USER root
RUN chmod -R 777 /home/jovyan/

USER $NB_UID




# Run the notebook
CMD ["/opt/conda/bin/jupyter", "lab", "--allow-root", "--port", "8558"]