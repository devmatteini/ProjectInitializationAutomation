### Installation

```
git clone "https://github.com/devmatteini/ProjectInitializationAutomation.git"

cd ProjectInitializationAutomation

pip install -r requirements.txt

source ~/.my_commands.sh
```

Then go to `create.py` and set the username and password or use a personal access token that
you can create from within the Github devoloper section in the settings.
Also make sure to change all directories to your
directories so it should be:

`/Users/<your_username>/path/to/your/project`

### Usage

#### Create A New Project

```bash
create <name_of_your_folder> [template_for_gitignore]
```

The `template_for_gitignore` is optional.

#### Open An Existing Project

```bash
dev [-c] <name_of_your_project>
```

The `-c` flag is optional. If you use it, it will open the project in visual studio code.
