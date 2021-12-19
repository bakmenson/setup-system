from os import walk, sep
from pathlib import Path

from setup_system.package import InstallMode, NeededPackage, PackageManager
from setup_system.read import read


def get_distro_name(path_to_file: Path) -> str:
    release_id: dict[str] = dict()
    for line in read(path_to_file):
        if line.startswith("ID"):
            key, distro_name = line.split("=")
            release_id[key] = distro_name
    return release_id.get("ID_LIKE", release_id.get("ID"))


def get_packages_paths(path_to_files: Path) -> dict[str, Path]:
    result: dict[str, Path] = dict()
    for path, _, files_names in walk(path_to_files):
        for file_name in files_names:
            result[file_name.split('.')[0]] = Path(f"{path}{sep}{file_name}")
    return result


def get_needed_packages(
        package_managers: list[PackageManager],
        packages: dict[str, Path],
        distro_name: str
) -> list[NeededPackage]:
    needed: list[NeededPackage] = list()
    for pm in package_managers:
        if pm.install_mode == InstallMode.MULTIPLE and pm.is_distro_dependence:
            if pm.distro_id and distro_name in pm.distro_id:
                needed.append(
                    NeededPackage(pm.command,
                                  pm.install_mode,
                                  packages.get(pm.name, f"{pm.name}.txt"),
                                  pm.priority)
                )
        else:
            needed.append(
                NeededPackage(pm.command,
                              pm.install_mode,
                              packages.get(pm.name, f"{pm.name}.txt"),
                              pm.priority)
            )
    return needed


def form_install_command(
        manager_command: str, packages_names: list[str], mode: InstallMode
) -> list[str]:
    match mode:
        case InstallMode.MULTIPLE:
            return f"{manager_command} {' '.join(packages_names)}".split(",")
        case InstallMode.SINGLE:
            separator = f",{manager_command} "
            return f"{manager_command} {separator.join(packages_names)}".split(",")
        case InstallMode.SOURCE:
            return packages_names


if __name__ == "__main__":
    pass
