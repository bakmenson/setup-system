from setup_system.mode import InstallMode


def form_install_command(
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
