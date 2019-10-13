from github import Github
from github.GithubException import UnknownObjectException
import sys

# If you want to use your username and password, instead of a personal access token:
# user = Github('USERNAME', 'PASSWORD').get_user()
user = Github('YOUR_PERSONAL_ACCESS_TOKEN').get_user()

try:
    user.get_repo(str(sys.argv[1])).delete()
    print('200')
except UnknownObjectException:
    print('404')
