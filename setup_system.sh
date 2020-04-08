#!/bin/bash

PATTERN="ID=(\w+)"
distr_name=""

while IFS= read -r line; do
	if [[ $line =~ ${PATTERN} ]]; then
		distr_name="${BASH_REMATCH[1]}"
	fi
done < /etc/os-release

cd ~/

if [ $distr_name == "ubuntu" ]; then
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

	# support python for neovim
	pip3 install pynvim --upgrade
else
	# put packages into file
	# pacman -Qqe > arch-packages.txt

	sudo pacman -S --needed - < arch-packages.txt
	# sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort arch-packages.txt))
fi

sleep 5

if [ ! -d ~/.oh-my-zsh ]; then
	{
		# oh-my-zsh
		wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
		chsh -s /bin/zsh
	} || {
		echo "" && echo "No wget" && exit 1
	}
fi

# pyenv and pyenv-virtualenv
if [ ! -d ~/.pyenv ]; then
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
fi

cd ~/

# i3-gaps for ubuntu
if [ $distr_name == "ubuntu" ]; then
	cd /tmp
	git clone https://www.github.com/Airblader/i3 i3-gaps
	cd i3-gaps
	autoreconf --force --install
	rm -rf build/
	mkdir -p build && cd build/
	../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
	make -j8
	sudo make install
fi

cd ~/

# polybar
if [ ! -d ~/polybar ]; then
	git clone https://github.com/jaagr/polybar.git
	cd polybar && ./build.sh
fi

cd ~/

mkdir Dev

# dotfiles
if [ ! -d ~/dotfiles ]; then
	git clone https://github.com/bakmenson/dotfiles.git ~/dotfiles
fi

cd ~/setup-system
chmod +x set_dotfiles.sh && ./set_dotfiles.sh

cd ~/

# colorpicker
if [ ! -d ~/.colorpicker ]; then
	git clone https://github.com/ym1234/colorpicker.git .colorpicker
	cd .colorpicker
	sudo make install
fi

cd ~/

# farge
if [ ! -d ~/.farge ]; then
	git clone https://github.com/sdushantha/farge .farge
	cd .farge
	sudo make install
fi

cd ~/

if [ ! -e ~/.inxi ]; then
	wget -O .inxi https://github.com/smxi/inxi/raw/master/inxi
	chmod +x .inxi
fi

chmod +x ~/.ufetch

vim-plug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

{
	# installing nvim plugings
	nvim +PlugInstall +qa
	nvim +sources ~/.config/nvim/init.vim +qa
	nvim +CocInstall coc-pyright +CocInstall coc-ultisnips +CocInstall coc-neosnippet +qa
} || {
	echo "" && echo "Error" && exit 1
}

# reboot system
# sudo reboot
