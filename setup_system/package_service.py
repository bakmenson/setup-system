from subprocess import run, PIPE, CalledProcessError
from os import walk, sep
from pathlib import Path

from setup_system.handle_error import handle_called_process_error, handle_os_error
from setup_system.mode import InstallMode
from setup_system.needed_package import NeededPackage
from setup_system.read import read


def files_paths(data_dir: Path) -> dict[str, Path]:
    files: dict[str, Path] = dict()

    for path, _, files_names in walk(data_dir):
        if files_names:
            for file_name in files_names:
                files[file_name.split('.')[0]] = Path(f"{path}{sep}{file_name}")

    return files


def _form_install_command(
        manager_command: str, packages_names: list[str], mode: InstallMode
) -> str:

    match mode:
        case InstallMode.MULTIPLE:
            return f"{manager_command} {' '.join(packages_names)}"
        case InstallMode.SINGLE:
            separator = f" && {manager_command} "
            return f"{manager_command} {separator.join(packages_names)}"
        case InstallMode.SOURCE:
            return " && ".join(packages_names)


if __name__ == "__main__":
    pass
