from github import Github
import sys

# g = Github('USERNAME', 'PASSWORD') auth with username and password
g = Github('YOUR_PERSONAL_ACCESS_TOKEN')

user = g.get_user()

res = user.create_repo(name=str(sys.argv[1]), private=True, gitignore_template=str(sys.argv[2]))