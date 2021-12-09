from pathlib import Path

from setup_system.mode import InstallMode
from setup_system.needed_package import NeededPackage
from setup_system.package_manager import package_managers
from setup_system.package_service import install, files_paths
from setup_system.read import read

OS_RELEASE_PATH: Path = Path("/etc/os-release")
PACKAGES_PATH: Path = Path("data/packages")

release_id: dict[str] = dict()

for item in read(OS_RELEASE_PATH):
    if item.startswith("ID"):
        temp: list[str] = item.split("=")
        release_id[temp[0]] = temp[1]

packages: dict[str, Path] = files_paths(PACKAGES_PATH)
if not packages:
    message: str = "Nothing to do or wrong path to packages files."
    print(f"\n{'-' * len(message)}\n{message}")
    exit()

needed_packages: list[NeededPackage] = list()

for pm in package_managers:
    match pm.install_mode, pm.is_distro_dependence:
        case InstallMode.MULTIPLE, True:
            if release_id.get("ID_LIKE", release_id.get("ID")) in pm.distro_id:
                needed_packages.append(
                    NeededPackage(pm.command,
                                  pm.install_mode,
                                  packages.get(pm.name, f"{pm.name}.txt"),
                                  pm.priority)
                )
        case (InstallMode.MULTIPLE | InstallMode.SINGLE), False:
            needed_packages.append(
                NeededPackage(pm.command,
                              pm.install_mode,
                              packages.get(pm.name, f"{pm.name}.txt"),
                              pm.priority)
            )
        case InstallMode.SOURCE, False:
            needed_packages.append(
                NeededPackage(pm.command,
                              pm.install_mode,
                              packages.get("from_source", "from_source.txt"),
                              pm.priority)
            )

needed_packages = sorted(needed_packages, key=lambda package: package.priority)

for needed_package in needed_packages:
    install(needed_package)
