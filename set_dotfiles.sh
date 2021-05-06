#!/bin/bash

if_exists_then_remove() {
	file="$1"

	if [[ -d "$file" ]]; then
		rm -rf "$file"
	elif [[ -f "$file" ]]; then
		rm "$file"
	fi
}

if [ ! -d ~/.config ]; then mkdir ~/.config; fi

# removing default configs or old dotfiles symlinks
while read -r file_path; do
	if_exists_then_remove "$file_path"
done < file_paths.txt

# creating symlinks for dotfiles
while read -r source dest; do
	ln -sf "$source" "$dest"
done < dotfiles_source_and_dest.txt

chmod +x ~/.ufetch-manjaro
chmod +x ~/.config/polybar/check-updates.sh
