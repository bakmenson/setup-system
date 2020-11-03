#!/bin/bash

sudo pacman -Syu

sudo pacman -S --needed - < ~/setup-system/manjaro-packages.txt

pip3 install --upgrade ipython

# oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
	git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# pyenv and pyenv-virtualenv
if [ ! -d ~/.pyenv ]; then
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
fi

cd ~/

# dotfiles
if [ ! -d ~/dotfiles ]; then
	git clone https://github.com/bakmenson/dotfiles.git ~/dotfiles
fi

cd ~/setup-system
bash set_dotfiles.sh

cd ~/

# mariadb
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service

# poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
mkdir $ZSH/plugins/poetry
poetry completions zsh > $ZSH/plugins/poetry/_poetry

# colorpicker
if [ ! -d ~/.colorpicker ]; then
	git clone https://github.com/ym1234/colorpicker.git .colorpicker
	cd .colorpicker
	sudo make install
fi

cd ~/

# farge
if [ ! -d ~/.farge ]; then
	git clone https://github.com/sdushantha/farge .farge
	cd .farge
	sudo make install
fi

cd ~/

# add automount hdd
sudo tee -a /etc/fstab > /dev/null <<EOT
UUID=43227ADD17F70CD0 /run/media/solus/hdd/      ntfs  errors=remount-ro,auto,exec,rw,user 0   0
EOT

tee -a ~/.config/ranger/rc.conf > /dev/null <<OET

# My keybindings
# =================================================================

# new tab
map tv tab_new /run/media/solus/hdd/Videos/
map tc tab_new ~/Dev/
map tw tab_new /run/media/solus/hdd/code_videos
map tu tab_new /run/media/solus/hdd/
map th tab_new ~/

# cd
map gv cd /run/media/solus/hdd/Videos/
map gc cd ~/Dev/
map gd cd ~/Downloads/
map gw cd /run/media/solus/hdd/code_videos/
map gu cd /run/media/solus/hdd/
OET

# neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo npm install -g typescript typescript-language-server
#pip3 install jedi 'python-language-server[yapf]' pyls-mypy pyls-isort flake8

# installing nvim plugings
#nvim +PlugInstall +qa
#nvim +sources ~/.config/nvim/init.vim +qa
#nvim +CocInstall coc-pyright +CocInstall coc-ultisnips +CocInstall coc-neosnippet +qa

## doom-emacs
#sudo npm install -g js-beautify
#sudo npm install -g marked
#
#mkdir .emacs.d
#git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
#~/.emacs.d/bin/doom install

# install jetbrains ide
if [ ! -d ~/jetbrains-downloader ]; then
	git clone https://github.com/bakmenson/jetbrains-downloader.git
fi

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
