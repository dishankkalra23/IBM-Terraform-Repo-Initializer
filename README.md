# Terraform IBM Modules Setup Script

## Description

This repository contains a shell script to automate the process of setting up a working environment for the [Terraform IBM Modules](https://github.com/IBM/terraform-ibm-modules) GitHub repository. The script handles the following tasks:

- Cloning the specified GitHub repository along with its submodules.
- Creating and activating a Python virtual environment.
- Installing the required dependencies if a `Makefile` is present.
- Pulling the latest changes from the main branch.
- Creating a new branch as specified by the user.

## Prerequisites

Before running the script, ensure that the following software is installed on your system:

- Git
- Python3 and `virtualenv`
- Bash shell

## Usage

1. Clone this repository to your local machine:

   ```bash
   git clone <repository-url>
   cd Terraform-IBM-Modules-Script
   ```

2. Make the script executable:

   ```bash
   chmod +x script.sh
   ```

3. Run the script:

   ```bash
    ./script.sh
   ```

The script will prompt you to enter the URL of the repository you wish to clone. It will also ask for the name of a new branch to create after pulling the latest changes.


## Repository Structure

```
Terraform-IBM-Modules-Script/
│
├── README.md
├── script.sh               # The main shell script for setting up the repository
├── .gitignore              # Ignored files and directories
├── venv/                   # Virtual environment directory (created by the script)
│   ├── bin/                
│   ├── lib/
│   └── ...
└── LICENSE                 # License for the repository (if applicable)
```
