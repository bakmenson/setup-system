from typing import NamedTuple

from setup_system.mode import InstallMode


class PackageManager(NamedTuple):
    priority: int
    name: str = "undefined"
    command: str = "undefined"
    install_mode: InstallMode = InstallMode.MULTIPLE
    is_distro_dependence: bool = False
    distro_id: tuple[str, ...] = None


package_managers: list[PackageManager] = [
    PackageManager(
        priority=1,
        name="apt",
        command="sudo apt install",
        is_distro_dependence=True,
        distro_id=("debian", "ubuntu"),
    ),
    PackageManager(
        priority=1,
        name="pacman",
        command="sudo pacman -S",
        is_distro_dependence=True,
        distro_id=("arch",),
    ),
    PackageManager(
        priority=1,
        name="dnf",
        command="sudo dnf install",
        is_distro_dependence=True,
        distro_id=("fedora", "rhel"),
    ),
    PackageManager(
        priority=1,
        name="zypper",
        command="sudo zypper install",
        is_distro_dependence=True,
        distro_id=("suse",),
    ),
    PackageManager(
        priority=2,
        name="npm",
        command="sudo npm install -g",
    ),
    PackageManager(
        priority=2,
        name="snap",
        command="sudo snap install",
        install_mode=InstallMode.SINGLE,
    ),
    PackageManager(
        priority=2,
        name="pip3",
        command="python3 -m pip install --upgrade pip && pip install",
    ),
    PackageManager(
        priority=3,
        install_mode=InstallMode.SOURCE,
    )
]

if __name__ == "__main__":
    pass
