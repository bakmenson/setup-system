from subprocess import run
from os import chdir, mkdir, makedirs
from os.path import expanduser
from pathlib import Path

from app.data import commands, repo_links, dotfile_links, old_dotfiles_paths
# from app.git import install_from_source

print(repo_links)
print(commands)
print(dotfile_links)
print(old_dotfiles_paths)

# run(["sudo", "pacman", "-S", "--needed", "-", "<", PACKAGES])

# chdir(str(Path.home()))

# for data in repos_data:
#     run(["git", "clone", f"https://github.com/{data.source}.git", data.dest])
#     if data.action:
#         chdir(data.dest)
#         print(Path().absolute())
#         # run(["sudo", "make", data.action])
#         chdir(str(Path.home()) + "/some")

# chdir(str(Path.home()))

# for command in commands:
#     run([*command.command])

# for old_dotfile_path in old_dotfiles_path:
#     if Path(expanduser(old_dotfile_path)).exists():
#         if Path(expanduser(old_dotfile_path)).is_dir():
#             run(["sudo", "rm", "-rf", expanduser(old_dotfile_path)])
#         else:
#             run(["sudo", "rm", expanduser(old_dotfile_path)])

# install_from_source(repos_data)
