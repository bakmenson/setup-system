from pathlib import Path, PosixPath
from subprocess import run, PIPE, CalledProcessError
from shlex import split
from os import chdir

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
home_path: Path = Path.expanduser(PosixPath("~"))

for command, mode, path, _ in needed_packages:
    for item in ps.form_install_command(command, read(path), mode):
        if item.startswith("git"):
            args = ps.git_clone(item.split("~/"), home_path)
        else:
            args = split(item)
        try:
            run(args, check=True, stderr=PIPE)
            if args[0] == "git":
                chdir(args[-1])
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
