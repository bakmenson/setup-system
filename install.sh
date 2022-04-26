#!/bin/zsh

zsh setup-system/setup-system.sh

rm setup-system/update.sh
rm setup-system/pre-install.sh
rm setup-system/setup-system.sh

mv ~/setup-system ~/dev/setup-system

echo "\n\nDone"
