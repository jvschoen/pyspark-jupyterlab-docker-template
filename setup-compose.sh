#!/bin/bash

# This script is used to create the docker image with the proper service name
# Mirroring the github repo name


# Get the name of the repo
repo_name=$(basename -s .git `git config --get remote.origin.url`)

# Making the service name in the docker-compose match the github repo name
echo "Editing Dockerfile with repo name ($repo_name) as service name"
sed "s/INSERT_REPO_NAME/${repo_name}/g" docker-compose.yml.tmpl > docker-compose.yml

docker-compose up