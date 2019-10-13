from github import Github
import sys

# If you want to use your username and password, instead of a personal access token:
# user = Github('USERNAME', 'PASSWORD').get_user()
user = Github('YOUR_PERSONAL_ACCESS_TOKEN').get_user()

gitignore_template = str(sys.argv[2]) if len(sys.argv) == 3 else ''

user.create_repo(name=str(sys.argv[1]), private=True, gitignore_template=gitignore_template)