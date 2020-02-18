#!/bin/bash

cd ~/

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s /bin/zsh
cp ~/dotfiles/.zshrc ~/

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

# i3 config
cp -r ~/dotfiles/i3 ~/.config

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
cp -r ~/dotfiles/polybar ~/.config

# dotfiles
cp ~/dotfiles/compton.conf ~/.config
cp ~/dotfiles/.ideavimrc ~/
cp -r ~/dotfiles/mpv ~/.config
cp -r ~/dotfiles/nvim ~/.config
cp -r ~/dotfiles/rofi ~/.config
cp -r ~/dotfiles/.gitconfig ~/
cp -r ~/dotfiles/.gitignore_global ~/
cp -r ~/dotfiles/.fonts ~/

reboot
