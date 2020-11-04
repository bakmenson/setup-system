#!/bin/bash

if [ ! -d ~/.config ]; then mkdir ~/.config; fi

if [ -d ~/.config/polybar ]; then rm -rf ~/.config/polybar; fi
if [ -d ~/.config/i3 ]; then rm -rf ~/.config/i3; fi
if [ -d ~/.config/mpv ]; then rm -rf ~/.config/mpv; fi
if [ -d ~/.config/vifm ]; then rm -rf ~/.config/vifm; fi
if [ -d ~/.config/rofi ]; then rm -rf ~/.config/rofi; fi
if [ -d ~/.config/xfce4/terminal ]; then rm -rf ~/.config/xfce4/terminal; fi
if [ -d ~/.fonts ]; then rm -rf ~/.fonts; fi
if [ -d ~/.doom.d ]; then rm -rf ~/.doom.d; fi
if [ -e ~/.config/compton.conf ]; then rm ~/.config/compton.conf; fi
if [ -e ~/.config/alacritty.yml ]; then rm ~/.config/alacritty.yml; fi
if [ -e ~/.oh-my-zsh/themes/wezm.zsh-theme ]; then rm ~/.oh-my-zsh/themes/wezm.zsh-theme; fi
if [ -e ~/.zshrc ]; then rm ~/.zshrc; fi
if [ -e ~/.oh-my-zsh/custom/themes/wezm.zsh-theme ]; then rm ~/.oh-my-zsh/custom/themes/wezm.zsh-theme; fi
if [ -e ~/.ideavimrc ]; then rm ~/.ideavimrc; fi
if [ -e ~/.gitconfig ]; then rm ~/.gitconfig; fi
if [ -e ~/.gitignore_global ]; then rm ~/.gitignore_global; fi
if [ -e ~/.ufetch ]; then rm ~/.ufetch; fi

mkdir ~/.config/nvim

ln -sf ~/dotfiles/polybar ~/.config/polybar
ln -sf ~/dotfiles/i3 ~/.config
ln -sf ~/dotfiles/mpv ~/.config
ln -sf ~/dotfiles/vifm ~/.config
ln -sf ~/dotfiles/rofi ~/.config
ln -sf ~/dotfiles/xfce4/terminal ~/.config/xfce4
ln -sf ~/dotfiles/.fonts ~/
ln -sf ~/dotfiles/.doom.d ~/
ln -sf ~/dotfiles/compton.conf ~/.config
ln -sf ~/dotfiles/alacritty.yml ~/.config
ln -sf ~/dotfiles/.ideavimrc ~/
ln -sf ~/dotfiles/.gitconfig ~/
ln -sf ~/dotfiles/.gitignore_global ~/
ln -sf ~/dotfiles/zsh/.zshrc ~/
ln -sf ~/dotfiles/zsh/wezm.zsh-theme ~/.oh-my-zsh/custom/themes

if [ -d ~/.i3 ]; then mv ~/.i3 ~/Documents; fi

ln -sf ~/dotfiles/.ufetch-manjaro ~/
mv ~/.ufetch-manjaro ~/.ufetch

chmod +x ~/.ufetch
chmod +x ~/.config/polybar/check-updates.sh
