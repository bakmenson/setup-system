from subprocess import run
from os import chdir, mkdir, makedirs
from os.path import expanduser
from pathlib import Path

from app.data import additions, git_repos, dotfiles_paths, old_dotfiles_paths,\
    PACKAGES

run(["sudo pacman -S --needed - < " + PACKAGES],
    shell=True, check=True, text=True)

chdir(str(Path.home()))

for git_repo in git_repos:
    if not Path(git_repo.dest).exists():
        run(["git", "clone",
            f"https://github.com/{git_repo.source}.git",
            git_repo.dest], check=True, text=True)

        if git_repo.action:
            chdir(git_repo.dest)
            run(["sudo", "make", git_repo.action], check=True, text=True)
            chdir(str(Path.home()))

for addition in additions:
    has_single_char_option: bool = False

    for i, elem in enumerate(addition.command):
        if elem.startswith("~"):
            addition.command[i] = expanduser(elem)
        if elem in (" - ", " < ", " > ", " | "):
            has_single_char_option = True
    if has_single_char_option:
        run([" ".join(addition.command)], shell=True, check=True, text=True)
    else:
        run([*addition.command], check=True, text=True)

for old_dotfile_path in old_dotfiles_paths:
    if Path(expanduser(old_dotfile_path)).exists():
        if Path(expanduser(old_dotfile_path)).is_dir():
            run(["sudo", "rm", "-rf", expanduser(old_dotfile_path)],
                check=True, text=True)
        else:
            run(["sudo", "rm", expanduser(old_dotfile_path)],
                check=True, text=True)

for dotfile_path in dotfiles_paths:
    if not Path(expanduser(dotfile_path.dest)).exists():
        makedirs(expanduser(dotfile_path.dest))
    run(["ln", "-sf", dotfile_path.source, expanduser(dotfile_path.dest)],
        check=True, text=True)

# TODO: import downloader.py
while(True):
    run(["python3", "jetbrains_downloader/downloader.py"])

    answer = input("Do you want install another IDE? (y/n)\n>>> ")

    while(answer != "y" and answer != "n"):
        print("Incorrent answer. Try again.")
        answer = input("Do you want install another IDE? (y/n)\n>>> ")

    if answer == "y":
        continue
    break
