#!/bin/bash

function create() {
    # Check required argument
    if [ -z "$1" ]; then
        echo -e "\033[33mUsage: create <name_of_the_project> [.gitignore_template]";
        return 1;
    fi
    
    # Check if project already exists
    cd ~/Documents/dev/    
    if [ -d "$1" ]; then 
        echo -e "\033[31m[!] Project already exist";
        return 1;
    fi

    # Execute python script that interacts with the GitHub API
    cd ~/bin/
    echo "[-] Generating github repository..."
    python3.7 create.py $1 $2
    echo -e "\033[32m[√] Github repository created successfully"
    echo -e "\033[39m------------------------------------"

    # Change dir to dev folder and create the new folder for this project
    echo "[-] Generating local repository..."
    cd ~/Documents/dev/
    mkdir $1 && cd $1
    
    # Init git folder. Add remote with ssh. Pull files created from the python script
    git init &> /dev/null
    git remote add origin git@github.com:devmatteini/$1.git &> /dev/null
    
    # If you leave the second argument empty there is nothing to be pulled from the repo
    if [ ! -z "$2" ]; then git pull origin master &> /dev/null; fi

    # Create README.md with the name of the project as its title
    touch README.md
    echo "# $1" >> README.md
    echo -e "\033[32m[√] Local repository created successfully"
    echo -e "\033[39m------------------------------------"

    # Add new files and commit
    echo "[-] Synchronizing local and remote repository..."
    git add . &> /dev/null
    git commit -m "Initial commit" &> /dev/null
    git push -u origin master &> /dev/null

    # Create a python virtual enviroment
    if [ "$2" = "Python" ]; then
        echo "[-] Generating python virtualenv..."
        python3 -m venv env &> /dev/null;
        source env/bin/activate &> /dev/null;
    fi
    echo -e "\033[32m[√] Synchronized local and remote repository successfully"
    echo -e "\033[39m------------------------------------"
    
    echo -e "\033[32m[√] Done"
    code .
}

function dev_usage_msg(){
    echo -e "\033[33mUsage: dev [-c] <name_of_your_project>"
}

function dev(){
    OPTIND=1
    current_dir=${PWD}
    while getopts ":c:" opt; do
        case $opt in
        c)
            cd ~/Documents/dev/
            if [ ! -d "$OPTARG" ]; then 
                echo -e "\033[31m[!] Project <$OPTARG> does not exist";
                cd $current_dir;
                return 1;
            fi
            cd $OPTARG
            # Activate python virtualenv, if it does exist
            if [ -d "./env" ]; then source env/bin/activate; fi
            code .
            return 0
            ;;
        \?)
            dev_usage_msg
            return 1
            ;;
        :)
            echo -e "\033[33m[!] Invalid option: -$OPTARG requires an argument: <name_of_your_project>." >&2
            return 1
            ;;
        esac
    done

    # NO OPTION PROVIDED
    if [ -z "$1" ]; then dev_usage_msg; return 1; fi

    cd ~/Documents/dev/
    if [ ! -d "$1" ]; then 
        echo -e "\033[31m[!] Project <$1> does not exists";
        cd $current_dir
        return 1;
    fi
    
    cd $1
    # Activate python virtualenv, if it does exist
    if [ -d "./env" ]; then source env/bin/activate; fi
}

function remove(){
    if [ -z "$1" ]; then echo -e "\033[33mUsage: remove <name_of_the_project>"; return 1; fi

    #subshell
    (
    cd ~/Documents/dev/ 
    if [ ! -d "$1" ]; then echo -e "\033[31m[!] Project does not exist"; return 1; fi

    echo -e "\033[39m[-] Removing github repository <$1>..."
    cd ~/bin/ && output=$(python3 delete.py $1)
    if [ $output = "404" ]; then echo -e "\033[31m[X] Github repository does not exist"; return 1; fi

    echo -e "\033[32m[√] Github repository removed successfully"
    echo -e "\033[39m------------------------------------"
    echo -e "\033[39m[-] Removing local repository <$1>..."

    cd ~/Documents/dev/ && rm -rf $1
    echo -e "\033[32m[√] Local repository removed successfully"
    echo -e "\033[39m------------------------------------"
    echo -e "\033[32m[√] Done"
    )
}