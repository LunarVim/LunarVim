#!/bin/bash

set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

PARAMS=""
while (( "$#" )); do
	case "$1" in
		-g|--global)
			GLOBAL=1
			shift
			;;
		-i|--info)
			INFO=1
			shift
			;;
		-*|--*=) # unsupported flags
			echo "Error: Unsupported flag $1" >&2
			exit 1
			;;
		*) # preserve positional arguments
			PARAMS="$PARAMS $1"
			shift
			;;
	esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

source lunarvim-env.sh

if [[ -v INFO ]]; then
	echo "LV_BASE: ${LV_BASE}"
	echo "LV_USER: ${LV_USER}"
	echo "LV_USER_CONFIG: ${LV_USER_CONFIG}"
	exit 1
fi

installnodemac() {
	brew install lua
	brew install node
	brew install yarn
}

installnodeubuntu() {
	sudo apt install nodejs
	sudo apt install npm
}

moveoldnvim() {
	echo "Not installing lunarvim"
	echo "Please move your ${LV_CONFIG_DIR} folder before installing"
	exit
}

installnodearch() {
	sudo pacman -S nodejs
	sudo pacman -S npm
}

installnode() {
	echo "Installing node..."
	[ "$(uname)" == "Darwin" ] && installnodemac
	[ -n "$(uname -a | grep Ubuntu)" ] && installnodeubuntu
	[ -f "/etc/arch-release" ] && installnodearch
	[ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
	sudo npm i -g neovim
}

installpiponmac() {
	sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python3 get-pip.py
	rm get-pip.py
}

installpiponubuntu() {
	sudo apt install python3-pip >/dev/null
}

installpiponarch() {
	pacman -S python-pip
}

installpip() {
	echo "Installing pip..."
	[ "$(uname)" == "Darwin" ] && installpiponmac
	[ -n "$(uname -a | grep Ubuntu)" ] && installpiponubuntu
	[ -f "/etc/arch-release" ] && installpiponarch
	[ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
}

installpynvim() {
	echo "Installing pynvim..."
	pip3 install pynvim --user
}

asktoinstallnode() {
	echo "node not found"
	echo -n "Would you like to install node now (y/n)? "
	read answer
	[ "$answer" != "${answer#[Yy]}" ] && installnode
}

asktoinstallpip() {
	# echo "pip not found"
	# echo -n "Would you like to install pip now (y/n)? "
	# read answer
	# [ "$answer" != "${answer#[Yy]}" ] && installpip
	echo "Please install pip3 before continuing with install"
	exit
}

installonmac() {
	brew install ripgrep fzf ranger
	npm install -g tree-sitter-cli
}

pipinstallueberzug() {
	which pip3 >/dev/null && pip3 install ueberzug || echo "Not installing ueberzug pip not found"
}

installonubuntu() {
	sudo apt install ripgrep fzf ranger
	sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev
	pip3 install ueberzug
	pip3 install neovim-remote
	npm install -g tree-sitter-cli
}

installonarch() {
	sudo pacman -S ripgrep fzf ranger
	which yay >/dev/null && yay -S python-ueberzug-git || pipinstallueberzug
	pip3 install neovim-remote
	npm install -g tree-sitter-cli
}

installextrapackages() {
	[ "$(uname)" == "Darwin" ] && installonmac
	[ -n "$(uname -a | grep Ubuntu)" ] && installonubuntu
	[ -f "/etc/arch-release" ] && installonarch
	[ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
}

global_cmd=""
[ -v GLOBAL ] && global_cmd="sudo"

update_lv_script() {
	[ -f "/usr/local/bin/lv" ] && ${global_cmd} rm /usr/local/bin/lv
	[ -f "/usr/local/bin/nv" ] && ${global_cmd} rm /usr/local/bin/nv
	${global_cmd} ln -s ${LV_CONFIG_DIR}/utils/bin/lv /usr/local/bin/lv
	${global_cmd} ln -s ${LV_CONFIG_DIR}/utils/bin/lv /usr/local/bin/nv
	${global_cmd} sed -i "s:source.*:source ${LV_CONFIG_DIR}/utils/bin/lunarvim-env.sh:g" ${LV_CONFIG_DIR}/utils/bin/lv
}
#
# Upgrade is only used for global installations.
#
upgrade_lunarvim() {
	echo upgrading
	cd ${LV_CONFIG_DIR} && sudo git fetch && sudo git reset --hard origin/lv.global-install
	update_lv_script
	[ -v GLOBAL ] && ${global_cmd} touch ${LV_BASE}/.packer_sync
}

install_lunarvim() {
	echo installing
	echo "Cloning lunarvim configuration"
	${global_cmd} mkdir -p ${LV_CONFIG_DIR}
	${global_cmd} git clone https://github.com/jameswalmsley/lunarvim.git -b lv.global-install ${LV_CONFIG_DIR}
	[ -v GLOBAL ] && update_lv_script
	${global_cmd} touch ${LV_BASE}/.packer_sync
}

# Welcome
echo 'Installing lunarvim'

if [ -v GLOBAL ]; then
	echo "Install a global configuration to ${LV_CONFIG_DIR}"
else
	echo "Installing a local configuration to ${LV_CONFIG_DIR}"
	[ -d "${LV_CONFIG_DIR}" ] && moveoldnvim
fi

# install pip
which pip3 >/dev/null && echo "pip installed, moving on..." || asktoinstallpip

# install node and neovim support
which node >/dev/null && echo "node installed, moving on..." || asktoinstallnode

# install pynvim
pip3 list | grep pynvim >/dev/null && echo "pynvim installed, moving on..." || installpynvim

# Install lunarvim configuration
[ -d "${LV_CONFIG_DIR}" ] && upgrade_lunarvim || install_lunarvim

