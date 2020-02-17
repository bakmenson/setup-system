from re import search
from subprocess import call


def get_data_from_file(file):
    list_of_words = []
    with open(file, 'r', encoding='UTF-8') as f:
        for word in f.readlines():
            list_of_words.append(word.rstrip('\n'))
    return list_of_words


os_release = get_data_from_file('/etc/os-release')
distro_name = search(r"ID=(\w+)", ' '.join(os_release)).group(1)

packages_file = distro_name + '-packages.txt'

packages_list = get_data_from_file(packages_file)
packages = ' '.join(packages_list)

if distro_name == 'ubuntu':
    call('sudo apt install ' + packages, shell=True)
elif distro_name == 'arch':
    call('sudo pacman -S ' + packages, shell=True)
else:
    pass

call('cp -r ~/dotfiles/i3 ~/.config', shell=True)

# build from source

# oh-my-zsh
call('cd ~/', shell=True)
call(
    'wget'
    ' https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh-O'
    ' - | zsh',
    shell=True
)
call('chsh -s /bin/zsh', shell=True)
call('cp ~/dotfiles/.zshrc ~/', shell=True)

# pyenv
if distro_name == 'ubuntu':
    call('sudo apt-get install -y make build-essential libssl-dev zlib1g-dev'
         ' libbz2-dev libreadline-dev libsqlite3-dev llvm'
         ' libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev'
         ' liblzma-dev', shell=True)

call('git clone https://github.com/pyenv/pyenv.git ~/.pyenv', shell=True)

# pyenv-virtualenv
call(
    'git clone https://github.com/pyenv/pyenv-virtualenv.git'
    ' $(pyenv root)/plugins/pyenv-virtualenv',
    shell=True
)

# i3-gaps for ubuntu
if distro_name == 'ubuntu':
    call('sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev'
         ' libxcb-util0-dev libxcb-icccm4-dev libyajl-dev'
         ' libstartup-notification0-dev libxcb-randr0-dev libev-dev'
         ' libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev'
         ' libxkb common-dev libxkbcommon-x11-dev autoconf libxcb-xrm0'
         ' libxcb-xrm-dev automake libxcb-shape0-dev', shell=True)
    call('cd /tmp', shell=True)
    call('git clone https://www.github.com/Airblader/i3 i3-gaps', shell=True)
    call('cd i3-gaps', shell=True)
    call('autoreconf --force --install', shell=True)
    call('rm -rf build/', shell=True)
    call('mkdir -p build && cd build/', shell=True)
    call(
        '../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers',
        shell=True
    )
    call('make -j8', shell=True)
    call('sudo make install', shell=True)
    call('cd ~/', shell=True)

# polybar
if distro_name == 'ubuntu':
    call('sudo apt-get install -y cmake cmake-data libcairo2-dev' \
         ' libxcb-ewmh-dev libxcb-image0-dev pkg-config python-xcbgen' \
         ' xcb-proto libasound2-dev libmpdclient-dev libiw-dev' \
         ' libcurl4-openssl-dev libpulse-dev' \
         ' libxcb-composite0-dev xcb libxcb-ewmh2', shell=True)
call('git clone https://github.com/jaagr/polybar.git', shell=True)
call('cd polybar && ./build.sh', shell=True)
call('cp -r ~/dotfiles/polybar ~/.config', shell=True)

call('cp ~/dotfiles/compton.conf ~/.config', shell=True)
call('cp ~/dotfiles/.ideavimrc ~/', shell=True)
call('cp -r ~/dotfiles/mpv ~/.config', shell=True)
call('cp -r ~/dotfiles/nvim ~/.config', shell=True)
call('cp -r ~/dotfiles/rofi ~/.config', shell=True)
call('cp -r ~/dotfiles/.gitconfig ~/', shell=True)
call('cp -r ~/dotfiles/.gitignore_global ~/', shell=True)

call('reboot', shell=True)
