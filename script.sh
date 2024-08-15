#!/bin/bash
##########
# Author: Dishank Kalra
# Description: A script to download the Terraform IBM Modules and perform the pre-requisite step required to start working
##########

# debugging
set -x

# stops the script if an error occurs
set -e

# checks for the error after pipes
set -o pipefail


read -p "Enter repository link: " repository_url
if [ -z "${repository_url}" ]; then
	echo "Repository URL cannot be empty."
	exit 1
fi

current_directory=$(pwd)
echo "The repository will be cloned in this location: " ${current_directory}  

# Clone the repository
git clone "${repository_url}" --recurse-submodules

# Check if the clone was successful
if [ $? -eq 0 ]; then
    echo "Repository cloned successfully."
else
    echo "Failed to clone the repository."
    exit 1
fi

# extract repo name using basename
repo_name=$(basename "${repository_url}" .git)

# Move to repo directory
cd "${repo_name}"

## execute following commands

# submodule initialisation
git submodule update --init

# create virtual environment
virtualenv venv

if [ $? -eq 0 ]; then
	echo "Virtual Environment created successfully."
else
	echo "Failed to create Virtual Environment"
fi

# Activate the virtual environment
source venv/bin/activate

# Execute commands inside the cloned repository
echo "Executing commands inside the cloned repository with the virtual environment activated..."

if [ -f "Makefile" ]; then
	echo "Running make command..."
	make
	if [ $? -eq 0 ]; then
		echo "Make command executed successfully."
	else
		echo "Make command failed."
		echo "Deactivating virtual environment"
		deactivate
		exit 1
	fi
else
	echo "No Makefile found. Skipping make command."
fi

# Pull the latest changes from the main/master branch
if (git show-ref --verify --quiet refs/heads/master); then
	default_branch="master"
elif (git show-ref --verify --quiet refs/heads/main); then
	default_branch="main"
fi

git pull origin "${default_branch}"

read -p "Enter the name of new branch to create: " branch_name
if [ -z "${branch_name}" ]; then
	echo "Branch name is empty. Exiting..."
	exit 1
else
	echo "Creating new branch..."
	git branch "${branch_name}"
fi
echo "${branch_name}"
deactivate
