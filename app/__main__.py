from subprocess import run
from os import chdir
from pathlib import Path

from app.data import commands, repo_links, dotfile_links
# from app.git import install_from_source

print(repo_links)
print(commands)
print(dotfile_links)

# chdir(str(Path.home()) + "/some")
#
# for data in repos_data:
#     run(["git", "clone", f"https://github.com/{data.source}.git", data.dest])
#     if data.action:
#         chdir(data.dest)
#         print(Path().absolute())
#         # run(["sudo", "make", data.action])
#         chdir(str(Path.home()) + "/some")

# for command in commands:
#     run([*command.command])

# run(["sudo", "pacman", "-S", "--needed", "-", "<", PACKAGES])

# install_from_source(repos_data)
