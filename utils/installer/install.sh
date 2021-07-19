#!/bin/sh
#Set Variable to master is not set differently
LVBRANCH="${LVBRANCH:-master}"
set -o nounset # error when referencing undefined variable
set -o errexit # exit when command fails

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
	echo "Not installing LunarVim"
	echo "Please move your ~/.config/nvim folder before installing"
	exit
}

installnodearch() {
	sudo pacman -S nodejs
	sudo pacman -S npm
}

installnodefedora() {
	sudo dnf install -y nodejs
	sudo dnf install -y npm
}

installnodegentoo() {
	echo "Printing current node status..."
	emerge -pqv net-libs/nodejs
	echo "Make sure the npm USE flag is enabled for net-libs/nodejs"
	echo "If it isn't enabled, would you like to enable it with flaggie? (Y/N)"
	read -r answer
	[ "$answer" != "${answer#[Yy]}" ] && sudo flaggie net-libs/nodejs +npm
	sudo emerge -avnN net-libs/nodejs
}

installnode() {
	echo "Installing node..."
	[ "$(uname)" = "Darwin" ] && installnodemac
	grep -q Ubuntu /etc/os-release && installnodeubuntu
	[ -f "/etc/arch-release" ] && installnodearch
	[ -f "/etc/artix-release" ] && installnodearch
	[ -f "/etc/fedora-release" ] && installnodefedora
	[ -f "/etc/gentoo-release" ] && installnodegentoo
	[ "$(uname -s | cut -c 1-10)" = "MINGW64_NT" ] && echo "Windows not currently supported"
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
	sudo pacman -S python-pip
}

installpiponfedora() {
	sudo dnf install -y pip >/dev/null
}

installpipongentoo() {
	sudo emerge -avn dev-python/pip
}

installpip() {
	echo "Installing pip..."
	[ "$(uname)" = "Darwin" ] && installpiponmac
	grep -q Ubuntu /etc/os-release && installpiponubuntu
	[ -f "/etc/arch-release" ] && installpiponarch
	[ -f "/etc/fedora-release" ] && installpiponfedora
	[ -f "/etc/gentoo-release" ] && installpipongentoo
	[ "$(uname -s | cut -c 1-10)" = "MINGW64_NT" ] && echo "Windows not currently supported"
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
	git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}

cloneconfig() {
	echo "Cloning LunarVim configuration"
	git clone --branch "$LVBRANCH" https://github.com/ChristianChiarulli/lunarvim.git ~/.config/nvim
	cp "$HOME/.config/nvim/utils/installer/lv-config.example-no-ts.lua" "$HOME/.config/nvim/lv-config.lua"
	nvim --headless \
		+'autocmd User PackerComplete sleep 100m | qall' \
		+PackerInstall

	nvim --headless \
		+'autocmd User PackerComplete sleep 100m | qall' \
		+PackerSync

	printf "\nCompile Complete\n"
	rm "$HOME/.config/nvim/lv-config.lua"
	cp "$HOME/.config/nvim/utils/installer/lv-config.example.lua" "$HOME/.config/nvim/lv-config.lua"
	# nvim --headless -cq ':silent TSUpdate' -cq ':qall' >/dev/null 2>&1
}

asktoinstallnode() {
	echo "node not found"
	printf "Would you like to install node now (y/n)? "
	read -r answer
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
	brew install ripgrep fzf
	npm install -g tree-sitter-cli
}

installonubuntu() {
	sudo apt install ripgrep fzf
	sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev
	pip3 install neovim-remote
	npm install -g tree-sitter-cli
}

installonarch() {
	sudo pacman -S ripgrep fzf
	pip3 install neovim-remote
	npm install -g tree-sitter-cli
}

installonfedora() {
	sudo dnf groupinstall "X Software Development"
	sudo dnf install -y fzf ripgrep
}

installongentoo() {
	sudo emerge -avn sys-apps/ripgrep app-shells/fzf dev-python/neovim-remote virtual/jpeg sys-libs/zlib
	npm install -g tree-sitter-cli
}

installextrapackages() {
	[ "$(uname)" = "Darwin" ] && installonmac
	grep -q Ubuntu /etc/os-release && installonubuntu
	[ -f "/etc/arch-release" ] && installonarch
	[ -f "/etc/artix-release" ] && installonarch
	[ -f "/etc/fedora-release" ] && installonfedora
	[ -f "/etc/gentoo-release" ] && installongentoo
	[ "$(uname -s | cut -c 1-10)" = "MINGW64_NT" ] && echo "Windows not currently supported"
}

# Welcome
echo 'Installing LunarVim'

case "$@" in
*--overwrite*)
	echo '!!Warning!! -> Removing all nvim related config because of the --overwrite flag'
	rm -rf "$HOME/.config/nvim"
	rm -rf "$HOME/.cache/nvim"
	rm -rf "$HOME/.local/share/nvim/site/pack/packer"
	;;
esac

# move old nvim directory if it exists
[ -d "$HOME/.config/nvim" ] && moveoldnvim

# install pip
(command -v pip3 >/dev/null && echo "pip installed, moving on...") || asktoinstallpip

# install node and neovim support
(command -v node >/dev/null && echo "node installed, moving on...") || asktoinstallnode

# install pynvim
(pip3 list | grep pynvim >/dev/null && echo "pynvim installed, moving on...") || installpynvim

if [ -e "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
	echo 'packer already installed'
else
	installpacker
fi

if [ -e "$HOME/.config/nvim/init.lua" ]; then
	echo 'LunarVim already installed'
else
	# clone config down
	cloneconfig
	# echo 'export PATH=$HOME/.config/nvim/utils/bin:$PATH' >>~/.zshrc
	# echo 'export PATH=$HOME/.config/lunarvim/utils/bin:$PATH' >>~/.bashrc
fi

echo "I recommend you also install and activate a font from here: https://github.com/ryanoasis/nerd-fonts"
# echo 'export PATH=/home/$USER/.config/lunarvim/utils/bin:$PATH appending to zshrc/bashrc'
