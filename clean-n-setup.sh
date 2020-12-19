
echo "Removing Docker base repo artifacts"
rm docker-compose.yml
rm Dockerfile
rm README.md

echo "creating empty README"
touch README.md

echo "Initializing Github Repo"
git init

echo "venv/*" > .gitignore
echo ".ipynb_checkpoints/" >> .gitignore

git add .
git commit -m 'New Data Science Project'
git checkout -b develop

