#!/bin/sh
#Set Variable to master if not set differently
LVBRANCH="${LVBRANCH:-master}"
USER_BIN_DIR="/usr/local/bin"
set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails


moveoldlvim() {
	echo "Not installing LunarVim"
	echo "Please move your ~/.local/share/lunarvim folder before installing"
	exit
}

installgit() {
	echo "git not found, please install git"
	exit
}

installpip() {
	echo "pip not found, please install pip"
	exit
}

installannvm() {
	echo "nodejs not found, please install a node version manager, then use that to install nodejs"
	exit
}

installpynvim() {
	echo "Installing pynvim..."
	if [ -f "/etc/gentoo-release" ]; then
		echo "Installing using Portage"
		sudo emerge -avn dev-python/pynvim
	else
		pip3 install pynvim --user
	fi
}

installpacker() {
	echo "Installing packer..."
	git clone https://github.com/wbthomason/packer.nvim ~/.local/share/lunarvim/site/pack/packer/start/packer.nvim
}

cloneconfig() {
	if [ -d "/data/data/com.termux" ]; then
		sudo() {
			eval "$@"
		}
		USER_BIN_DIR="$HOME/../usr/bin"
	fi
	echo "Cloning LunarVim configuration"
#	mkdir -p ~/.local/share/lunarvim   directory already exists at this point
	case "$@" in

	*--testing*)
		cp -r "$(pwd)" ~/.local/share/lunarvim/lvim
		;;
	*)
		git clone --branch "$LVBRANCH" https://github.com/lunarvim/lunarvim.git ~/.local/share/lunarvim/lvim
		;;
	esac
	mkdir -p "$HOME/.config/lvim"
	sudo cp "$HOME/.local/share/lunarvim/lvim/utils/bin/lvim" "$USER_BIN_DIR"
	sudo chmod a+rx "$USER_BIN_DIR"/lvim
	cp "$HOME/.local/share/lunarvim/lvim/utils/installer/config.example-no-ts.lua" "$HOME/.config/lvim/config.lua"

	nvim -u ~/.local/share/lunarvim/lvim/init.lua --cmd "set runtimepath+=~/.local/share/lunarvim/lvim" --headless \
		+'autocmd User PackerComplete sleep 100m | qall' \
		+PackerInstall

	nvim -u ~/.local/share/lunarvim/lvim/init.lua --cmd "set runtimepath+=~/.local/share/lunarvim/lvim" --headless \
		+'autocmd User PackerComplete sleep 100m | qall' \
		+PackerSync

	printf "\nCompile Complete\n"

	
#	if [ -e "$HOME/.local/share/lunarvim/lvim/init.lua" ]; then
#		echo 'config.lua already present'
#	else
#		cp "$HOME/.local/share/lunarvim/lvim/utils/installer/config.example.lua" "$HOME/.config/lvim/config.lua"
#	fi

}

installonmac() {
	brew install lua ripgrep fzf
	npm install -g neovim tree-sitter-cli
	pip3 install neovim-remote neovim
}

installonubuntu() {
	sudo apt install ripgrep fzf xclip
	sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev
	pip3 install neovim-remote neovim
	npm install -g neovim tree-sitter-cli
}

installonarch() {
	sudo pacman -S ripgrep fzf xclip python
	pip3 install neovim-remote neovim
	npm install -g neovim tree-sitter-cli
}

installonfedora() {
	sudo dnf groupinstall "X Software Development"
	sudo dnf install -y fzf ripgrep xclip python3-devel
	pip3 install neovim-remote neovim
	npm install -g neovim tree-sitter-cli
}

installongentoo() {
	sudo emerge -avn sys-apps/ripgrep app-shells/fzf dev-python/neovim-remote virtual/jpeg sys-libs/zlib
	npm install -g neovim tree-sitter-cli
}

installtermux() {
	apt install ripgrep fzf
	pip install neovim-remote neovim
	npm install -g neovim tree-sitter-cli
}

installextrapackages() {
	[ "$(uname)" = "Darwin" ] && installonmac
	grep -q Ubuntu /etc/os-release && installonubuntu
	[ -f "/etc/arch-release" ] && installonarch
	[ -f "/etc/artix-release" ] && installonarch
	[ -f "/etc/fedora-release" ] && installonfedora
	[ -f "/etc/gentoo-release" ] && installongentoo
	[ -d "/data/data/com.termux" ] && installtermux
	[ "$(uname -s | cut -c 1-10)" = "MINGW64_NT" ] && echo "Windows not currently supported"
}

# Welcome
echo 'Installing LunarVim'

case "$@" in
*--overwrite*)
	echo '!!Warning!! -> Removing all lunarvim related config because of the --overwrite flag'
	rm -rf "$HOME/.local/share/lunarvim"
	rm -rf "$HOME/.cache/nvim"
	rm -rf "$HOME/.config/lvim"
	;;
esac

# move old lvim directory if it exists
[ -d "$HOME/.local/share/lunarvim" ] && moveoldlvim

# check for git
(command -v git >/dev/null && echo "git installed, moving on...") || installgit

# install pip
(command -v pip3 >/dev/null && echo "pip installed, moving on...") || installpip

# check for node
(command -v node >/dev/null && echo "node installed, moving on...") || installannvm 

# install pynvim
(pip3 list | grep pynvim >/dev/null && echo "pynvim installed, moving on...") || installpynvim

#user has already been asked to move this directory, for the script to run it cannot exist
#if [ -e "$HOME/.local/share/lunarvim/site/pack/packer/start/packer.nvim" ]; then
#	echo 'packer already installed'
#else

installpacker

#fi


#same as above, this branch will not be hit
#if [ -e "$HOME/.local/share/lunarvim/lvim/init.lua" ]; then
#	echo 'LunarVim already installed'
#else
	# clone config down

cloneconfig "$@"

	# echo 'export PATH=$HOME/.config/nvim/utils/bin:$PATH' >>~/.zshrc
	# echo 'export PATH=$HOME/.config/lunarvim/utils/bin:$PATH' >>~/.bashrc
#fi

if [ "$(uname)" != "Darwin" ]; then
	if [ -e "$HOME/.local/share/applications/lvim.desktop" ]; then
		echo 'Desktop file already available'
	else
		mkdir -p "$HOME/.local/share/applications"
		cp "$HOME/.local/share/lunarvim/lvim/utils/desktop/lvim.desktop" "$HOME/.local/share/applications/lvim.desktop"
	fi
fi


# install extra packages
echo "installing extra packages"
echo "I recommend you also install and activate a font from here: https://github.com/ryanoasis/nerd-fonts"
installextrapackages

# echo 'export PATH=/home/$USER/.config/lunarvim/utils/bin:$PATH appending to zshrc/bashrc'
