#!/bin/bash

function create() {
    # Check if project already exists
    cd ~/Documents/dev/    
    if [ -d "$1" ]; then 
        echo "Project already exits";
        return 1;
    fi

    # Execute python script that interacts with the GitHub API
    cd ~/bin/
    python3.7 create.py $1 $2

    # Change dir to dev folder and create the new folder for this project
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
    git add .
    git commit -m "Initial commit"
    git push -u origin master
    echo Done
    code .
}