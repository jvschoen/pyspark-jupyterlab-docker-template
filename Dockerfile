FROM jupyter/pyspark-notebook

USER root

# Add essential packages
RUN apt-get update && apt-get install -y build-essential curl git gnupg2 nano apt-transport-https software-properties-common openssh-client

# Set locale
RUN apt-get update && apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen


# Make the project directory and copy project contents
RUN mkdir /home/jovyan/project/
COPY --chown=$NB_UID:$NB_UID ./. /home/jovyan/project/

# Jupyter config for Custom styling and custom port number
RUN mkdir -p /home/jovyan/.jupyter/custom
COPY --chown=$NB_UID:$NB_UID extras/custom/custom.css /home/jovyan/.jupyter/custom/
COPY --chown=$NB_UID:$NB_UID extras/jupyter/jupyter_notebook_config.py /home/jovyan/.jupyter/

# Spark libraries for use with AWS
RUN wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar -P $SPARK_HOME/jars/
RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar -P $SPARK_HOME/jars/

# Download and install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
# Cleanup aws cli source 
RUN rm -r ./aws 
RUN rm awscliv2.zip

# Install Python requirements at user scope
USER $NB_UID
RUN pip install --upgrade pip
RUN pip install -r /home/jovyan/project/requirements.txt
# To be able to use table of contents
RUN pip install --upgrade jupyterlab-git

# Make r/w for all
USER root
RUN chmod -R 777 /home/jovyan/