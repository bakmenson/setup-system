from typing import NamedTuple
from pathlib import Path
from enum import Enum, auto


class InstallMode(Enum):
    SINGLE = auto()
    MULTIPLE = auto()
    SOURCE = auto()

    def __eq__(self, other):
        return self.name == other.name


class NeededPackage(NamedTuple):
    command: str
    install_mode: InstallMode
    path: Path
    priority: int


class PackageManager(NamedTuple):
    priority: int
    name: str
    command: str
    install_mode: InstallMode
    is_distro_dependence: bool
    distro_id: list[str, ...]


if __name__ == "__main__":
    pass
