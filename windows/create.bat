@ECHO OFF

REM Check required argument
IF [%1]==[] (
    ECHO Usage: create ^<name_of_the_project^> ^[.gitignore_template^]
    EXIT /B 1
)

set project="Z:\DEV2\%~1" 

REM Check if a project name alreadt exists
IF EXIST "%project%" (
    ECHO [!] Project already exists
    EXIT /B 1
)

REM Execute python script that interacts with the GitHub API
ECHO [-] Generating github repository...
IF %CD:~0,3% NEQ "C:\" (
    C:   
)
cd C:\bin
python create.py %1 %2


REM Create project folder and initialize Git
ECHO [-] Generating local repository...
Z:
cd DEV2 && mkdir %1 && cd %1

git init
git remote add origin git@github.com:devmatteini/%1.git

REM REM If you leave the second argument empty there is nothing to be pulled from the repo
IF NOT [%2] == [] (
    git pull origin master
)

ECHO # %1 > README.md

ECHO [-] Synchronizing local and remote repository...
git add .
git commit -m "Initial commit"
git push origin master

ECHO [OK] DONE
code .