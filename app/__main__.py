from subprocess import run
from os import chdir, mkdir, makedirs
from os.path import expanduser
from pathlib import Path

from app.data import additions, git_repos, dotfiles_paths, old_dotfiles_paths,\
    PACKAGES, packages

# TODO: fix installing packages from a file as a list
# run(["sudo", "pacman", "-S", "--needed", "-", "<", PACKAGES])
run(["sudo", "pacman", "-S", "--needed", *packages])
# command = run(["sudo", "pacman", "-S", "--needed", *packages])
# if command.returncode != 0:
#     exit()

chdir(str(Path.home()))

for git_repo in git_repos:
    run(["git", "clone",
         f"https://github.com/{git_repo.source}.git",
         git_repo.dest])
    if git_repo.action:
        chdir(git_repo.dest)
        run(["sudo", "make", git_repo.action])
        chdir(str(Path.home()))

for addition in additions:
    for i, elem in enumerate(addition.command):
        if elem.startswith("~"):
            addition.command[i] = expanduser(elem)
    run([*addition.command])

for old_dotfile_path in old_dotfiles_paths:
    if Path(expanduser(old_dotfile_path)).exists():
        if Path(expanduser(old_dotfile_path)).is_dir():
            run(["sudo", "rm", "-rf", expanduser(old_dotfile_path)])
        else:
            run(["sudo", "rm", expanduser(old_dotfile_path)])

for dotfile_path in dotfiles_paths:
    if not Path(expanduser(dotfile_path.dest)).exists():
        makedirs(expanduser(dotfile_path.dest))
    run(["ln", "-sf", dotfile_path.source, expanduser(dotfile_path.dest)])
