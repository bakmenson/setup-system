from os import walk, sep
from pathlib import Path

from setup_system.handle_error import handle_file_not_found_error


def read(file_path: Path) -> list[str]:
    content: list[str] = []

    try:
        with open(file=file_path, mode="r", encoding="utf-8") as f:
            content = f.read().splitlines()
    except FileNotFoundError:
        handle_file_not_found_error(file_path)

    return list(filter(None, content))


def get_files(path_to_dir: Path) -> dict[str, Path]:
    files: dict[str, Path] = dict()

    for path, _, files_names in walk(path_to_dir):
        if files_names:
            for file_name in files_names:
                files[file_name.split('.')[0]] = Path(f"{path}{sep}{file_name}")

    return files


if __name__ == "__main__":
    pass
