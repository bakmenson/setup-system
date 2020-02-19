#!/bin/bash

PATTERN="ID=(\w+)"
distr_name=""

while IFS= read -r line; do
	if [[ $line =~ ${PATTERN} ]]; then
		distr_name="${BASH_REMATCH[1]}"
	fi
done < /etc/os-release

cd ~/

if [[ $distr_name == "ubuntu" ]]; then
	sudo apt update && sudo apt -y dist-upgrade && sudo apt -y autoremove
	sudo apt install -y $(cat ubuntu-packages.txt)

	# packages for pyenv
	sudo apt install -y make build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev llvm \
	libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev \
	liblzma-dev

	# packages for i3-gaps
	sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
	libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
	libstartup-notification0-dev libxcb-randr0-dev libev-dev \
	libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev \
	libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 \
	libxcb-xrm-dev automake libev-dev libstartup-notification0-dev \
	libxcb-xrm-dev libxcb-shape0-dev

	# packages for polybar
	sudo apt -y install cmake cmake-data libcairo2-dev libxcb1-dev \
	libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev \
	libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config \
	python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev \
	libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev \
	libxcb-composite0-dev xcb libxcb-ewmh2 libjsoncpp-dev

	# nodejs
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
	sudo apt install -y nodejs
	curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt install -y yarn

elif [[ $distr_name == "arch" ]]; then
	# put packages into file
	# pacman -Qqe > arch-packages.txt

	sudo pacman -S --needed - < arch-packages.txt
	# sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort arch-packages.txt))
fi

# oh-my-zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s /bin/zsh

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

# i3-gaps
cd /tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make -j8
sudo make install

cd ~/

# polybar
git clone https://github.com/jaagr/polybar.git
cd polybar && ./build.sh

cd ~/

# vim-plug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# dotfiles
if [ -d ~/.config/polybar ]; then rm -rf ~/.config/polybar; fi
if [ -d ~/.config/i3 ]; then rm -rf ~/.config/i3; fi
if [ -d ~/.config/mpv ]; then rm -rf ~/.config/mpv; fi
if [ -d ~/.config/nvim ]; then rm -rf ~/.config/nvim; fi
if [ -d ~/.config/rofi ]; then rm -rf ~/.config/rofi; fi
if [ -d ~/.config/xfce4/terminal ]; then rm -rf ~/.config/xfce4/terminal; fi
if [ -d ~/.fonts ]; then rm -rf ~/.fonts; fi
if [ -e ~/.config/compton.conf ]; then rm ~/.config/compton.conf; fi
if [ -e ~/.zshrc ]; then rm ~/.zshrc; fi
if [ -e ~/.ideavimrc ]; then rm ~/.ideavimrc; fi
if [ -e ~/.gitconfig ]; then rm ~/.gitconfig; fi
if [ -e ~/.gitignore_global ]; then rm ~/.gitignore_global; fi

ln -s ~/dotfiles/.zshrc ~/
ln -s ~/dotfiles/compton.conf ~/.config
ln -s ~/dotfiles/.ideavimrc ~/
ln -s ~/dotfiles/i3 ~/.config
ln -s ~/dotfiles/polybar ~/.config
ln -s ~/dotfiles/mpv ~/.config
ln -s ~/dotfiles/nvim ~/.config
ln -s ~/dotfiles/rofi ~/.config
ln -s ~/dotfiles/.gitconfig ~/
ln -s ~/dotfiles/.gitignore_global ~/
ln -s ~/dotfiles/.fonts ~/
ln -s ~/dotfiles/xfce4/terminal ~/.config/xfce4

# reboot system
sudo reboot
