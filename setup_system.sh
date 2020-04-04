#!/bin/bash

# put packages into file
# pacman -Qqe > arch-packages.txt

sudo pacman -S --needed - < arch-packages.txt
# sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort arch-packages.txt))

sleep 5

{
	# oh-my-zsh
	wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
	chsh -s /bin/zsh
} || {
	echo "" && echo "Noe wget" && exit 1
}

# pyenv
if [ ! -d ~/.pyenv ]; then
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
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
if [ ! -d ~/polybar ]; then
	git clone https://github.com/bakmenson/dotfiles.git ~/dotfiles
fi

cd ~/setup-system
chmod +x set_dotfiles.sh && ./set_dotfiles.sh

cd ~/

chmod +x ~/.ufetch

# vim-plug for neovim
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
