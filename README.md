# ProjectInitializationAutomation

Script (either for linux or windows) to use when you have to create a new project and don't want to do the same (boring) things everytime.

## Installation

### Linux

```bash
git clone "https://github.com/devmatteini/ProjectInitializationAutomation.git"

cd ProjectInitializationAutomation

pip install -r requirements.txt

source ~/.my_commands.sh
```

### Windows

```bash
git clone "https://github.com/devmatteini/ProjectInitializationAutomation.git"

cd ProjectInitializationAutomation

pip install -r requirements.txt
```

If you want to use the `create` batch script from everywhere, you have to add to your system environment variables the file's path (I put my batch file under `C:\bin` but you can change it).
_If you don't know how to change environment variables check out this [guide](https://www.architectryan.com/2018/08/31/how-to-change-environment-variables-on-windows-10/)_.

## Usage

#### Create A New Project

```bash
create <name_of_your_project> [.gitignore_template]
```

The `.gitignore_template` needs to follow the [names](https://github.com/github/gitignore) used by Github, in order to generate it correctly via the GithubAPI.

#### Open An Existing Project (Only on Linux)

```bash
dev [-c] <name_of_your_project>
```

The `-c` flag is optional. If you use it, it will open the project in visual studio code.


#### Delete An Existing Project (Only on Linux)

```bash
remove <name_of_your_project>
```