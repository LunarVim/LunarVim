#!/usr/bin/env bash

set -o nounset  # error when referencing undefined variable
set -o errexit  # exit when command fails
set -o pipefail # prevent errors in pipelines from being masked

main() {
	echo 'Installing LunarVim'
	move_old_nvim
	ask_to_install_pip
	ask_to_install_node
	install_pynvim
	install_packer
	lunarvim_clone_config
	lunarvim_bootstrap
	echo
	echo "It is recommended to install and activate a font from here: https://github.com/ryanoasis/nerd-fonts"
	echo
}

# Handle existing nvim installations
move_old_nvim() {
	[ ! -d "${HOME}/.config/nvim" ] && return
	echo "Not installing LunarVim"
	echo "Please move your ~/.config/nvim folder before installing"
	exit
}

#
# User Interaction
#

ask_to_install_node() {
	if which node >/dev/null; then
		echo "node installed, moving on..."
		return
	fi

	echo "node not found"
	echo -n "Would you like to install node now (y/n)? "
	read -r answer
	[ "$answer" != "${answer#[Yy]}" ] && install_node
}

ask_to_install_pip() {
	if which pip3 >/dev/null; then
		echo "pip installed, moving on..."
		return
	fi

	# echo "pip not found"
	# echo -n "Would you like to install pip now (y/n)? "
	# read answer
	# [ "$answer" != "${answer#[Yy]}" ] && install_pip
	echo "Please install pip3 before continuing with install"
	exit
}

#
# Node Installation
#

install_node() {
	echo "Installing node..."
	[ "$(uname)" == "Darwin" ] && install_mac_node
	grep -q "Ubuntu" /etc/os-release && install_ubuntu_node
	[ -f "/etc/arch-release" ] && install_arch_node
	[ -f "/etc/artix-release" ] && install_arch_node
	[ -f "/etc/fedora-release" ] && install_fedora_node
	[ -f "/etc/gentoo-release" ] && install_gentoo_node
	[[ $(uname -s) == MINGW64_NT* ]] \
		&& echo "Windows not currently supported"
	sudo npm i -g neovim
}

install_mac_node() {
	brew install lua
	brew install node
	brew install yarn
}

install_ubuntu_node() {
	sudo apt install nodejs
	sudo apt install npm
}

install_arch_node() {
	sudo pacman -S nodejs
	sudo pacman -S npm
}

install_fedora_node() {
	sudo dnf install -y nodejs
	sudo dnf install -y npm
}

install_gentoo_node() {
	echo "Printing current node status..."
	emerge -pqv net-libs/nodejs
	echo "Make sure the npm USE flag is enabled for net-libs/nodejs"
	echo "If it isn't enabled, would you like to enable it with flaggie? (Y/N)"
	read -r answer
	[ "$answer" != "${answer#[Yy]}" ] && sudo flaggie net-libs/nodejs +npm
	sudo emerge -avnN net-libs/nodejs
}

#
# Pip Installation
#

install_pip() {
	echo "Installing pip..."
	[ "$(uname)" == "Darwin" ] && install_mac_pip
	grep -q "Ubuntu" /etc/os-release && install_ubuntu_pip
	[ -f "/etc/arch-release" ] && install_arch_pip
	[ -f "/etc/fedora-release" ] && install_fedora_pip
	[ -f "/etc/gentoo-release" ] && install_gentoo_pip
	[[ $(uname -s) == MINGW64_NT* ]] \
		&& echo "Windows not currently supported"
}

install_mac_pip() {
	sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python3 get-pip.py
	rm get-pip.py
}

install_ubuntu_pip() {
	sudo apt install python3-pip >/dev/null
}

install_arch_pip() {
	sudo pacman -S python-pip
}

install_fedora_pip() {
	sudo dnf install -y pip >/dev/null
}

install_gentoo_pip() {
	sudo emerge -avn dev-python/pip
}

#
# Component Installation
#

install_pynvim() {
	if pip3 list | grep pynvim >/dev/null; then
		echo "pynvim installed, moving on..."
		return
	fi

	echo "Installing pynvim..."
	if [ -f "/etc/gentoo-release" ]; then
		echo "Installing using Portage"
		sudo emerge -avn dev-python/pynvim
	else
		pip3 install pynvim --user
	fi
}

install_packer() {
	if [ -e "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
		echo 'packer already installed'
		return
	fi

	git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}

pip_install_ueberzug() {
	if which pip3 >/dev/null; then
		pip3 install ueberzug
	else
		echo "Not installing ueberzug pip not found"
	fi
}

#
# Extra Package Installation
#
# FIXME: this is never called!

install_extra_packages() {
	[ "$(uname)" == "Darwin" ] && install_mac_extras
	grep -q "Ubuntu" /etc/os-release && install_ubuntu_extras
	[ -f "/etc/arch-release" ] && install_arch_extras
	[ -f "/etc/artix-release" ] && install_arch_extras
	[ -f "/etc/fedora-release" ] && install_fedora_extras
	[ -f "/etc/gentoo-release" ] && install_gentoo_extras
	[[ $(uname -s) == MINGW64_NT* ]] \
		&& echo "Windows not currently supported"
}

install_mac_extras() {
	brew install ripgrep fzf ranger
	npm install -g tree-sitter-cli
}

install_ubuntu_extras() {
	sudo apt install ripgrep fzf ranger
	sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev
	pip3 install ueberzug
	pip3 install neovim-remote
	npm install -g tree-sitter-cli
}

install_arch_extras() {
	sudo pacman -S ripgrep fzf ranger

	if which yay >/dev/null; then
		yay -S python-ueberzug-git
	else
		pip_install_ueberzug
	fi

	pip3 install neovim-remote
	npm install -g tree-sitter-cli
}

install_fedora_extras() {
	sudo dnf groupinstall "X Software Development"
	sudo dnf install -y fzf ripgrep ranger
	pip3 install wheel ueberzug
}

install_gentoo_extras() {
	sudo emerge -avn sys-apps/ripgrep app-shells/fzf app-misc/ranger dev-python/neovim-remote virtual/jpeg sys-libs/zlib
	pip_install_ueberzug
	npm install -g tree-sitter-cli
}

#
# NVim Config / Bootstrap
#

lunarvim_clone_config() {
	if [ -e "$HOME/.config/nvim/init.lua" ]; then
		echo 'LunarVim already installed'
		return
	fi

	# echo 'export PATH=$HOME/.config/nvim/utils/bin:$PATH' >>~/.zshrc
	# echo 'export PATH=$HOME/.config/lunarvim/utils/bin:$PATH' >>~/.bashrc

	echo "Cloning LunarVim configuration"
	git clone https://github.com/ChristianChiarulli/lunarvim.git ~/.config/nvim
	mv "${HOME}/.config/nvim/utils/installer/lv-config.example.lua" \
		"${HOME}/.config/nvim/lv-config.lua"
}

lunarvim_bootstrap() {
	# mv "${HOME}/.config/nvim/utils/init.lua" "${HOME}/.config/nvim/init.lua"
	nvim -u "${HOME}/.config/nvim/init.lua" "+PackerInstall"
	# rm "${HOME}/.config/nvim/init.lua"
	# mv "${HOME}/.config/nvim/init.lua.tmp" "${HOME}/.config/nvim/init.lua"
}

main

# echo "I also recommend you add 'set preview_images_method ueberzug' to ~/.config/ranger/rc.conf"
# echo 'export PATH=/home/$USER/.config/lunarvim/utils/bin:$PATH appending to zshrc/bashrc'
