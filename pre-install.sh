#!/bin/bash

sudo pacman -Syu

sudo pacman -S --needed emacs fish

mkdir -p ~/dev

emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "setup-system/README.org")'

chsh -s /bin/fish

reboot
