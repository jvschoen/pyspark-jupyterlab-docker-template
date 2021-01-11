# Docker Use Overview
This is a Data Science pyspark project creator. It creates a standard docker environment running jupyterlab and pyspark 3.0.

Creating a repo from this template will allow you to work locally to develop pyspark-driven research.

When in jupyterlab, there is a folder labeled `notebooks` which mirrors the local jupyter/notebooks dir. Work from the noteoboks folder in juptyer lab and your work will be synced to your local instance, and thus available for git to track. 

## Github

You will not be able to access the git repo from the jupyter lab instance, but as long as your work takes place in the notebook directory on jupyter lab, then your files will be saved locally as well. You must run git commands from your local computer to push and pull locally and thus have access to the files in your jupyter docker container.

## Steps
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

### AWS
In order for access to AWS services, you must have the `~/.aws/credentials` on your local environment. The Docker instance has mounted this file as an external volume, so as you update your credentials locally, they will be live on your docker instance. This file is **not editable** from your docker instance, and only editable from your local OS.

### Twitter
If you are testing the Twitter sections of the notebook, you must first have developer api keys and access tokens. You can apply for one [here](https://developer.twitter.com/en/apply-for-access). The way this data is accessed is from your local home directory in a subdir called `.secrets`. Please create this directory and create a json file (`$HOME/.secrets/twitter.json`) with the following structure:

```json
{
    "api_key": "API KEY from twitter",
    "api_secret_key": "API SECRET KEY from twitter",
    "bearer_token": "BEARER TOKEN FOR curl Access",
    "access_token": "ACCESS TOKEN",
    "access_token_secret": "ACCESS TOKEN SECRET"
}
```
Some documentation for tweepy will use different naming for these keys:
```
CONSUMER_KEY = API_KEY
CONSUMER_SECRET = API_SECRET_KEY
CONSUMER_TOKEN = ACCESS_TOKEN
CONSUMER_TOKEN_SECRET = ACCESS_TOKEN_SECRETD
```

This file will be accessible as a volume in the docker container with read-only access

# New Project Overview

Once the docker image has been built above, then the following should be followed to get the notebook set up with table of contents extension and to understand how git is managed.

## Getting Started

**Create notebooks in the notebooks directory**. Anything in the root dir of the jupyter lab instance **will not be synced locally** and thus not able to be saved locally and pushed to github. In this directory there are some example notebooks to familiarize with good ways to get started using pyspark in a jupyter environment.

A good place to start is going to `notebooks/GETTING STARTED`

## TO DO:

You may be prompted to re build jupyter lab, this is fine just click build.

# Resources

https://medium.com/@ntruong/jupyterlab-setup-for-my-data-team-84e5724d1bea

https://stackoverflow.com/questions/57138221/error-trying-to-access-aws-s3-using-pyspark

https://www.jitsejan.com/integrating-pyspark-notebook-with-s3.html


spark_version: The Spark version to install (3.0.0).
hadoop_version: The Hadoop version (3.2).
spark_checksum: The package checksum (BFE4540...).