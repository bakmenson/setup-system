#!/bin/bash

sudo apt install -y zsh
touch ~/.zshrc
sudo snap install emacs --classic
chsh -s /bin/zsh
reboot
