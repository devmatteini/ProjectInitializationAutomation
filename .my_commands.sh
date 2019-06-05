#!/bin/bash

function create(){
    echo Initializing...

    # Execute python script that interacts with the GitHub API
    cd ~/bin/
    python3.7 create_repository.py $1 $2

    # Change dir to dev folder and create the new folder for this project
    cd ~/Documents/dev/
    mkdir $1 && cd $1
    
    # Init git folder. Add remote with ssh. Pull files created from the python script
    git init
    git remote add origin git@github.com:devmatteini/$1.git
    git pull origin master
    
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