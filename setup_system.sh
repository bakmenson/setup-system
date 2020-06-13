#!/bin/bash

sudo pacman -Syu
pip3 install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib ipython

sudo pacman -S --needed - < ~/setup-system/manjaro-packages.txt

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

# spacemacs javascript layer

sudo npm i -g import-js
import_js_status=$?

if [[ $import_js_status -eq 1 ]]; then
	sudo npm i --unsafe-perm -g import-js
fi

sudo npm i -g eslint
sudo npm i -g prettier
sudo npm i -g typescript typescript-language-server

cd ~/

# polybar
if [ ! -d ~/polybar ]; then
	git clone https://github.com/jaagr/polybar.git
	cd polybar && ./build.sh
fi

cd ~/

# dotfiles
if [ ! -d ~/dotfiles ]; then
	git clone https://github.com/bakmenson/dotfiles.git ~/dotfiles
fi

cd ~/setup-system
chmod +x set_dotfiles.sh && ./set_dotfiles.sh

cd ~/

# mariadb
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service

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

if [ ! -e ~/.inxi ]; then
	wget -O .inxi https://github.com/smxi/inxi/raw/master/inxi
	chmod +x .inxi
fi

# add automount hdd
sudo tee -a /etc/fstab > /dev/null <<EOT
UUID=43227ADD17F70CD0 /run/media/solus/hdd/      ntfs  errors=remount-ro,auto,exec,rw,user 0   0
EOT

# vim-plug for neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# installing nvim plugings
nvim +PlugInstall +qa
nvim +sources ~/.config/nvim/init.vim +qa
nvim +CocInstall coc-pyright +CocInstall coc-ultisnips +CocInstall coc-neosnippet +qa

chsh -s /bin/zsh

# reboot system
# sudo reboot
