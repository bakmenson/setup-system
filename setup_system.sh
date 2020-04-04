#!/bin/bash

# put packages into file
# pacman -Qqe > arch-packages.txt

sudo pacman -S --needed - < arch-packages.txt
# sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort arch-packages.txt))

# oh-my-zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s /bin/zsh

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

cd ~/

# polybar
git clone https://github.com/jaagr/polybar.git
cd polybar && ./build.sh

cd ~/

mkdir Dev

# dotfiles
git clone https://github.com/bakmenson/dotfiles.git ~/dotfiles

cd ~/setup-system
chmod +x set_dotfiles.sh && ./set_dotfiles.sh

cd ~/

chmod +x ~/.ufetch

# vim-plug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# installing nvim plugings
nvim +PlugInstall +qa
nvim +sources ~/.config/nvim/init.vim +qa
nvim +CocInstall coc-pyright +CocInstall coc-ultisnips +CocInstall coc-neosnippet +qa

# reboot system
# sudo reboot
