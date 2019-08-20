#!/bin/bash

function create() {
    # Check required argument
    if [ ! -z "$1" ]; then
        echo "Usage: create <name_of_the_project> [.gitignore_template]";
        return 1;
    fi
    
    # Check if project already exists
    cd ~/Documents/dev/    
    if [ -d "$1" ]; then 
        echo "[!] Project already exist";
        return 1;
    fi

    # Execute python script that interacts with the GitHub API
    cd ~/bin/
    echo "[-] Generating github repository..."
    python3.7 create.py $1 $2

    # Change dir to dev folder and create the new folder for this project
    echo "[-] Generating local repository..."
    cd ~/Documents/dev/
    mkdir $1 && cd $1
    
    # Init git folder. Add remote with ssh. Pull files created from the python script
    git init
    git remote add origin git@github.com:devmatteini/$1.git
    
    # If you leave the second argument empty there is nothing to be pulled from the repo
    if [ ! -z "$2" ]; then git pull origin master; fi

    # Create README.md with the name of the project as its title
    touch README.md
    echo "# $1" >> README.md

    # Add new files and commit
    echo "[-] Synchronizing local and remote repository..."
    git add .
    git commit -m "Initial commit"
    git push -u origin master

    # Create a python virtual enviroment
    if [ "$2" = "Python" ]; then
        echo "[-] Generating python virtualenv..."
        python3 -m venv env;
        source env/bin/activate;
    fi
    
    echo "[√] Done"
    code .
}
