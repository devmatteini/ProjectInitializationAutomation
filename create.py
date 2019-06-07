from github import Github
import sys

# g = Github('USERNAME', 'PASSWORD') auth with username and password
g = Github('YOUR_PERSONAL_ACCESS_TOKEN')

user = g.get_user()

gitignore_template = str(sys.argv[2]) if len(sys.argv) == 3 else ''

res = user.create_repo(name=str(sys.argv[1]), private=True, gitignore_template=gitignore_template)