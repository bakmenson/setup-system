from pathlib import Path, PosixPath
from subprocess import run, PIPE, CalledProcessError
from shlex import split
from os import chdir, mkdir
from shutil import rmtree

import setup_system.service as ps
from setup_system.package import NeededPackage
from setup_system.read import read, read_package_managers

OS_RELEASE_PATH: Path = Path("/etc/os-release")
PACKAGES_NAMES_PATH: Path = Path("setup_system/data/packages")
PACKAGE_MANAGERS_PATH: Path = Path("setup_system/data/package_managers.txt")

distro_name: str = ps.get_distro_name(OS_RELEASE_PATH)

needed_packages: list[NeededPackage] = ps.get_needed_packages(
    read_package_managers(PACKAGE_MANAGERS_PATH, "|"),
    ps.get_packages_paths(PACKAGES_NAMES_PATH),
    ps.get_distro_name(OS_RELEASE_PATH)
)

needed_packages.sort(key=lambda package: package.priority)

commands: list[str] = list()
args: list[str] = []

for command, mode, path, _ in needed_packages:
    for item in ps.form_install_command(command, read(path), mode):
        args = split(item)
        if "cd" == args[0]:
            chdir(ps.expand_path(args[1]))
            args = []
        elif "mkdir" == args[0]:
            mkdir(ps.expand_path(args[1]))
            args = []
        elif "git" == args[0]:
            args = ps.form_git_command(args)
            if Path(args[-1]).exists():
                rmtree(args[-1])
        if args:
            try:
                run(args, check=True, stderr=PIPE)
            except CalledProcessError as e:
                try:
                    run(" ".join(args), shell=True, check=True, stderr=PIPE)
                except CalledProcessError as e:
                    if not e.stderr:
                        exit(1)
                    print(f"\n{'=' * 50}\n{e.stderr}")
                    exit(e.args[0])
            except OSError as e:
                print(e)
                exit(1)
