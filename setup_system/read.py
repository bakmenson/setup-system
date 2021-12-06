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


if __name__ == "__main__":
    pass
