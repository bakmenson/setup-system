from collections import namedtuple

from app.read import read_data
# from git import install_from_git

GIT_REPOS_PATH: str = "app/data/repos_links.txt"
COMMANDS_PATH: str = "app/data/commands.txt"
PACKAGES_PATH: str = "app/data/manjaro-packages.txt"
DOTFILES_PATH: str = "app/data/dotfiles_paths.txt"
OLD_DOTFILES_PATH: str = "app/data/old_dotfiles_paths.txt"

DotfileLinks = namedtuple("DotfileLinks", ["source", "dest"])
RepoLinks = namedtuple("RepoLinks", ["source", "dest", "action"], defaults=(None,))
Command = namedtuple("Command", ["command"])

commands: list[Command] = list(
    map(lambda c: Command(c.strip().split()), read_data(COMMANDS_PATH))
)
repo_links: list[RepoLinks] = list(
    map(lambda d: RepoLinks(*d.strip().split()), read_data(GIT_REPOS_PATH))
)
dotfile_links: list[DotfileLinks] = list(
    map(lambda d: DotfileLinks(*d.strip().split()), read_data(DOTFILES_PATH))
)
old_dotfiles_path: list = list(
    map(lambda o: o.strip(), read_data(OLD_DOTFILES_PATH))
)
