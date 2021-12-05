from pathlib import Path
from typing import NamedTuple

from setup_system.mode import InstallMode


class NeededPackage(NamedTuple):
    command: str
    install_mode: InstallMode
    path: Path
    priority: int
