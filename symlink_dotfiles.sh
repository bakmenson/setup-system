#!/bin/bash

cd ~/

ln -s ~/dotfiles/.zshrc ~/
ln -s ~/dotfiles/compton.conf ~/.config
ln -s ~/dotfiles/.ideavimrc ~/
ln -s ~/dotfiles/i3 ~/.config
rm -fr ~/.config/polybar
ln -s ~/dotfiles/polybar ~/.config
ln -s ~/dotfiles/mpv ~/.config
ln -s ~/dotfiles/nvim ~/.config
ln -s ~/dotfiles/rofi ~/.config
ln -s ~/dotfiles/.gitconfig ~/
ln -s ~/dotfiles/.gitignore_global ~/
ln -s ~/dotfiles/.fonts ~/
ln -s ~/dotfiles/xfce4/terminal ~/.config/xfce4
