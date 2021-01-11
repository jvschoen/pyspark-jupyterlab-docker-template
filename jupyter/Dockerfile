FROM jupyter/pyspark-notebook:${JUPYTER_VERSION:-latest}

COPY ./notebooks/requirements.txt notebooks/requirements.txt
RUN pip install -r ./notebooks/requirements.txt
RUN pip install --upgrade jupyterlab

# Jupyter config for Custom styling and custom port number
RUN mkdir -p /home/jovyan/.jupyter/custom
COPY --chown=$NB_UID:$NB_UID jupyter/custom/custom.css /home/jovyan/.jupyter/custom/

# To be able to run 3.0.0 https://github.com/jupyter/docker-stacks/issues/1205
# May not be required if the Jupyter docker stack updates.
# used to only require jupyter_notebook_config, but now need a jupyter_server_config that 
# uses a ServerApp object instead of NotebookApp object
RUN cp /etc/jupyter/jupyter_notebook_config.py /etc/jupyter/jupyter_server_config.py
RUN sed -i 's/NotebookApp/ServerApp/g' /etc/jupyter/jupyter_server_config.py

EXPOSE 8558