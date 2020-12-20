# Overview
This is a Data Science pyspark project creator. It creates a standard docker environment running jupyterlab and pyspark 3.0.

Creating a repo from this template will allow the jupyter instance to already by connected to a remote github repo so all work can be easily version controlled in github.

When in jupyterlab, there is a folder labeled `project` which mirrors the github repo mentioned above. Work from the project folder and your work will be tracked in the project's github repo

Steps
1. Create a new Github Repo from this template
2. Clone locally
3. GO into `docker-compose.yml` file an change the service name by replacing `INSERT_NAME_HERE`
4. Run `docker-compose up`

This will create a docker image with the same name as the repo created and cloned locally. Now you can access JupyterLab where the home drive mirrors the project drive from the local OS.

During the build a build, this readme will be replaced with an empty readme and git will already be initialized. You will be able to open a jupyter notebook and freely run spark. 









https://medium.com/@ntruong/jupyterlab-setup-for-my-data-team-84e5724d1bea

https://stackoverflow.com/questions/57138221/error-trying-to-access-aws-s3-using-pyspark

https://www.jitsejan.com/integrating-pyspark-notebook-with-s3.html


spark_version: The Spark version to install (3.0.0).
hadoop_version: The Hadoop version (3.2).
spark_checksum: The package checksum (BFE4540...).
