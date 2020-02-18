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
    call('sudo apt update && sudo apt dist-upgrade && sudo apt autoremove',
         shell=True)
    call('sudo apt install ' + packages, shell=True)
elif distro_name == 'arch':
    call('sudo pacman -S ' + packages, shell=True)
else:
    pass

# packages for building from source

if distro_name == 'ubuntu':

    # pyenv
    call('sudo apt install -y make build-essential libssl-dev zlib1g-dev'
         ' libbz2-dev libreadline-dev libsqlite3-dev llvm'
         ' libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev'
         ' liblzma-dev', shell=True)

    # i3-gaps
    call('sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev'
         ' libxcb-util0-dev libxcb-icccm4-dev libyajl-dev'
         ' libstartup-notification0-dev libxcb-randr0-dev libev-dev'
         ' libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev'
         ' libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0'
         ' libxcb-xrm-dev automake libev-dev libstartup-notification0-dev'
         ' libxcb-xrm-dev libxcb-shape0-dev', shell=True)

    # polybar
    call('sudo apt install cmake cmake-data libcairo2-dev libxcb1-dev'
         ' libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev'
         ' libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config'
         ' python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev'
         ' libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev'
         ' libxcb-composite0-dev xcb libxcb-ewmh2 libjsoncpp-dev', shell=True)

call('chmod +x packages_from_source.sh', shell=True)
call('./packages_from_source.sh')
