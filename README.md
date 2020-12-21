# Docker Use Overview
This is a Data Science pyspark project creator. It creates a standard docker environment running jupyterlab and pyspark 3.0.

Creating a repo from this template will allow the jupyter instance to already by connected to a remote github repo so all work can be easily version controlled in github.

When in jupyterlab, there is a folder labeled `project` which mirrors the github repo mentioned above. Work from the project folder and your work will be tracked in the project's github repo

Steps
1. Create a new Github Repo from this template
2. Clone locally
3. run `sh setup-compose.sh`. This will create a docker image with the service name mirroring the github repo name. 
    * This is achieved by replacing a placeholder `INSERT_REPO_NAME` with the output from 
        basename -s .git `git config --get remote.origin.url`

This will create a docker image with the same name as the repo created and cloned locally. Now you can access JupyterLab where the home drive mirrors the project drive from the local OS.

## Building across devices
Once you make changes to your code, git commit and push to github, all code will be synced between your local repo, the dockerized repo and the github repo. If you clone the repo to work from another device, you simply just have to run `sh ./setup-compose.sh` again, and the image will build. This is the purpose of the following contents which **should not be modified**:
    * Dockerfile
    * docker-compose.yml.tmpl
    * setup-compose.sh
    * .dockerignore
    * extras/

## Credentials.

In order for access to AWS services, you must have the `~/.aws/credentials` on your local environment. The Docker instance has mounted this file as an external volume, so as you update your credentials locally, they will be live on your docker instance. This file is **not editable** from your docker instance, and only editable from your local OS.


# New Project Overview

Once the docker image has been built above, then the following should be followed to get the notebook set up with table of contents extension and to understand how git is managed.

## Getting Started
Git has already been initialized. JupyterLab's home directory is mirroring root project directory from the local OS. git

Create notebooks in the notebooks directory. In this directory there are some example notebooks to familiarize with good ways to get started using pyspark in a jupyter environment.

A good place to start is going to `notebooks/GETTING STARTED`

## TO DO:

Must go install jupyterlab/toc. Choose the extensions icon from the left sidebar in JupyterLab. Enable 3rd party extensions and install jupyterlab/toc. After installing you'll need to do a rebuild jupyterlab, a message will inform you. 


Select Settings in the top menu bar and go to "Advanced Settings" and choose Table of Contents. Set this attribute in to override the default non collapsible behavior of the table of contents extension. 
`{"collapsibleNotebooks": true}`


# Resources

https://medium.com/@ntruong/jupyterlab-setup-for-my-data-team-84e5724d1bea

https://stackoverflow.com/questions/57138221/error-trying-to-access-aws-s3-using-pyspark

https://www.jitsejan.com/integrating-pyspark-notebook-with-s3.html


spark_version: The Spark version to install (3.0.0).
hadoop_version: The Hadoop version (3.2).
spark_checksum: The package checksum (BFE4540...).
