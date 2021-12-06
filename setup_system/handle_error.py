from subprocess import CalledProcessError
from pathlib import Path


def handle_called_process_error(error: CalledProcessError, path: Path) -> None:
    if not error.stderr:
        exit(1)

    exit_code, command = error.args
    print(f"\n{'=' * 50}\nError while executing command:\n'{command}'\n\n"
          f"From file: '{path}'")

    print(f"\n{'=' * 50}\nThe reason:\n{error.stderr}")

    exit(exit_code)


def handle_os_error(error: OSError) -> None:
    print(error)
    exit(1)


def handle_file_not_found_error(path: Path) -> None:
    message: str = f"Oops! Can't read file '{path}'."
    separator: str = "=" * len(message)
    print(f"{separator}\n{message}\n{separator}")
    exit(1)
