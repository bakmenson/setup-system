from pathlib import Path
from csv import reader

from setup_system.package import PackageManager, InstallMode


def read(file_path: Path) -> list[str]:
    content: list[str] = []

    try:
        with open(file=file_path, mode="r", encoding="utf-8") as f:
            content = f.read().splitlines()
    except FileNotFoundError:
        _file_not_found_error(file_path)

    return list(filter(None, content))


def read_package_managers(file_path: Path, delimiter: str) -> list[PackageManager]:
    managers: list[PackageManager] = []

    try:
        with open(file=file_path, mode="r", encoding="utf-8") as f:
            csv_reader = reader(f, delimiter=delimiter)
            next(csv_reader)
            for row in csv_reader:
                managers.append(
                    PackageManager(
                        priority=int(row[0]),
                        name=row[1],
                        command=row[2],
                        install_mode=InstallMode[row[3]],
                        is_distro_dependence=True if row[4] == "True" else False,
                        distro_id=row[5].split(",") if row[5] else None
                    )
                )
    except FileNotFoundError:
        _file_not_found_error(file_path)

    return managers


def _file_not_found_error(path: Path) -> None:
    message: str = f"Oops! Can't read file '{path}'."
    separator: str = "=" * len(message)
    print(f"{separator}\n{message}\n{separator}")
    exit(1)


if __name__ == "__main__":
    pass
