#!/bin/bash

# This script is used to create the docker image with the proper service name
# Mirroring the github repo name


# Get the name of the repo
repo_name=$(basename -s .git `git config --get remote.origin.url`)

# Making the service name in the docker-compose match the github repo name
echo "Editing docker-compose.yml. Appending repo name ($repo_name) to container name"
sed -i "s/INSERT_REPO_NAME/${repo_name}/g" docker-compose.yml

docker-compose up