from pathlib import Path
from subprocess import run, PIPE, CalledProcessError

import setup_system.service as ps
from setup_system.package import NeededPackage
from setup_system.read import read, read_package_managers

OS_RELEASE_PATH: Path = Path("/etc/os-release")
PACKAGES_NAMES_PATH: Path = Path("data/packages")
PACKAGE_MANAGERS_PATH: Path = Path("data/package_managers.txt")

distro_name: str = ps.get_distro_name(OS_RELEASE_PATH)

needed_packages: list[NeededPackage] = ps.get_needed_packages(
    read_package_managers(PACKAGE_MANAGERS_PATH, "|"),
    ps.get_packages_paths(PACKAGES_NAMES_PATH),
    ps.get_distro_name(OS_RELEASE_PATH)
)
needed_packages = sorted(needed_packages, key=lambda package: package.priority)

commands: list[str] = list()
for command, mode, path, _ in needed_packages:
    for item in ps.form_install_command(command, read(path), mode):
        commands.append(item)

install_command: str = " && ".join(commands)

try:
    run(install_command, shell=True, check=True, stderr=PIPE, encoding="utf-8")
except CalledProcessError as e:
    if not e.stderr:
        exit(1)
    print(f"\n{'=' * 50}\n{e.stderr}")
    exit(e.args[0])
except OSError as e:
    print(e)
    exit(1)
