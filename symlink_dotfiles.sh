#!/bin/bash

cd ~/

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
