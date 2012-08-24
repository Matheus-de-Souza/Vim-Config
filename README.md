
Hi! It is my VIM configuration.

I like it a lot. Maybe you could think the same. :)

# Installation

## Windows

Open powershell and run:

	git clone https://github.com/Matheus-de-Souza/Vim-Config.git ~/.vim
	cd ~/.vim
	git submodule init
	git submodule foreach git pull origin master
	cmd /c mklink /H ~/_vimrc ~/.vim/.vimrc

## Mac/Linux

Open terminal and run:

	git clone https://github.com/Matheus-de-Souza/Vim-Config.git ~/.vim
	cd ~/.vim
	git submodule init
	git submodule foreach git pull origin master
	ln -s ~/.vim/.vimrc ~/.vimrc

Obs.: This configuration was only tested on windows. If you has other OS, use at your own risk.
