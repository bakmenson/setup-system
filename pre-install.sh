#!/bin/bash

sudo pacman -Syu

sudo pacman -S emacs

mkdir -p ~/dev

emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "setup-system/README.org")'

reboot
