#!/usr/bin/env bash

install_from_source() {
	action="${4:-install}"
	"$@"
	cd "$3"
	sudo make "$action"
	cd ~/
}

git_clone() {
	repo="$1"
	dest="$2"

	if [ ! -d ~/"$dest" ]; then
		git clone https://github.com/"$repo".git ~/"$dest"
	fi
}

cd ~/

sudo pacman -Syu

sudo pacman -S --needed - < ~/setup-system/manjaro-packages.txt

pip3 install --upgrade ipython

# color scripts for terminal
yay -S shell-color-script

# mariadb
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service

# add automount hdd
sudo tee -a /etc/fstab > /dev/null <<EOT
UUID=43227ADD17F70CD0 /run/media/solus/hdd/      ntfs  errors=remount-ro,auto,exec,rw,user 0   0
EOT

# neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo npm install -g typescript typescript-language-server
#pip3 install jedi 'python-language-server[yapf]' pyls-mypy pyls-isort flake8

# installing nvim plugings
#nvim +PlugInstall +qa
#nvim +sources ~/.config/nvim/init.vim +qa

# oh-my-zsh
git_clone ohmyzsh/ohmyzsh .oh-my-zsh
git_clone zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git_clone zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git_clone zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
mkdir $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry

# pyenv and pyenv-virtualenv
git_clone pyenv/pyenv .pyenv
git_clone pyenv/pyenv-virtualenv .pyenv/plugins/pyenv-virtualenv

# my dotfiles
git_clone bakmenson/dotfiles dotfiles
cd ~/setup-system
bash set_dotfiles.sh

cd ~/

# colorpicker
install_from_source git_clone ym1234/colorpicker .colorpicker

# farge
install_from_source git_clone sdushantha/farge .farge

# nnn file manager
install_from_source git_clone jarun/nnn .nnn O_NERD=1
cp ~/.nnn/nnn /usr/bin/

# install jetbrains ide
git_clone bakmenson/jetbrains-downloader jetbrains-downloader
while true; do
	printf "\n"
	python3 ~/jetbrains-downloader/downloader.py

	printf "\nDo you want install another IDE? (y/n)"
	read -s -n 1 answer
	[[ $answer == "" || $answer == "y" ]] || break
done
rm -rf jetbrains-downloader

# change shell
chsh -s /bin/zsh

# reboot system
# sudo reboot
