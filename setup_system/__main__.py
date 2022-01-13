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
POST_INSTALL_PATH: Path = Path("setup_system/data/post_install.txt")

needed_packages: list[NeededPackage] = ps.get_needed_packages(
    read_package_managers(PACKAGE_MANAGERS_PATH, "|"),
    ps.get_packages_paths(PACKAGES_NAMES_PATH),
    ps.get_distro_name(OS_RELEASE_PATH)
)

needed_packages.sort(key=lambda package: package.priority)

split_commands: list[list[str]] = []

for command, mode, path, _ in needed_packages:
    for item in ps.form_install_command(command, read(path), mode):
        split_commands.append(split(item))

post_install_commands: list[str] = read(POST_INSTALL_PATH)
for command in post_install_commands:
    split_commands.append(split(command))

for split_command in split_commands:
    for item in split_command:
        if item.startswith("~"):
            new_item = Path.expanduser(PosixPath(item))
            item_idx = split_command.index(item)
            split_command.insert(item_idx, str(new_item))
            split_command.remove(item)

    if "cd" == split_command[0]:
        if Path(split_command[1]).exists():
            chdir(split_command[1])
        split_command = None
    elif "mkdir" == split_command[0]:
        if not Path(split_command[1]).exists():
            mkdir(split_command[1])
        split_command = None
    elif "rm" == split_command[0]:
        path_to_rm: Path = Path.home().joinpath(Path(split_command[-1]))
        if path_to_rm.exists():
            if path_to_rm.is_dir():
                rmtree(path_to_rm)
            else:
                Path.unlink(path_to_rm)
        split_command = None
    elif "git" == split_command[0] and len(split_command) == 3:
        clone_dest = Path.home().joinpath(Path(split_command[2]).stem)
        if clone_dest.exists():
            rmtree(clone_dest)
        split_command.append(str(clone_dest))

    if split_command is not None:
        try:
            run(split_command, check=True, stderr=PIPE)
        except CalledProcessError as e:
            try:
                run(" ".join(split_command), shell=True, check=True, stderr=PIPE, encoding="utf-8")
            except CalledProcessError as e:
                if not e.stderr:
                    exit(1)
                print(f"\n{'=' * 50}\n{e.stderr}")
                exit(e.args[0])
        except OSError as e:
            print(e)
            exit(1)
