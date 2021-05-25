from subprocess import run
from os import chdir
from pathlib import Path

from data import RepoLinks


def install_from_source(datas: list[RepoLinks]) -> None:
    chdir(str(Path.home()) + "/some")
    for data in datas:
        run(["git", "clone", f"https://github.com/{data.source}.git", data.dest])
        if data.action:
            chdir(data.dest)
            print(Path().absolute())
            # run(["sudo", "make", data.action])
            chdir(str(Path.home()) + "/some")
