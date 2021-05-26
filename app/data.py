from collections import namedtuple

from app.read import read_data
# from git import install_from_git

GIT_REPOS: str = "app/data/repos_links.txt"
ADDITIONS: str = "app/data/additional_commands.txt"
PACKAGES: str = "app/data/manjaro-packages.txt"
DOTFILES: str = "app/data/dotfiles_paths.txt"
OLD_DOTFILES: str = "app/data/old_dotfiles_paths.txt"

DotfileLinks = namedtuple("DotfileLinks", ["source", "dest"])
RepoLinks = namedtuple("RepoLinks", ["source", "dest", "action"], defaults=(None,))
Command = namedtuple("Command", ["command"])

additions: list[Command] = list(
    map(lambda c: Command(c.strip().split()), read_data(ADDITIONS))
)
git_repos: list[RepoLinks] = list(
    map(lambda d: RepoLinks(*d.strip().split()), read_data(GIT_REPOS))
)
dotfiles_paths: list[DotfileLinks] = list(
    map(lambda d: DotfileLinks(*d.strip().split()), read_data(DOTFILES))
)
old_dotfiles_paths: list = list(
    map(lambda o: o.strip(), read_data(OLD_DOTFILES))
)
packages: list = list(
    map(lambda p: p.strip(), read_data(PACKAGES))
)
