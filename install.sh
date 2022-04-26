#!/bin/zsh

emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "setup-system/README.org")'
zsh setup-system/setup-system.sh
rm setup-system/setup-system.sh
mv ~/setup-system ~/dev/setup-system
echo "\n\nDone"
