#!/bin/bash

# Updating the package list
apt-get update

# Installing dependencies
apt-get -y install tzdata sudo git nodejs npm git ripgrep fzf ranger curl fonts-hack-ttf

pip3 install ueberzug neovim-remote
npm install tree-sitter-cli neovim

# Installing Neovim
mkdir -p /tmp/neovim
cd /tmp/neovim || exit
curl -L -o nvim.appimage https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
mv squashfs-root /usr/local/neovim
ln -s /usr/local/neovim/usr/bin/nvim /usr/bin/nvim
rm ./nvim.appimage

# Installing LunarVim
LVBRANCH=master bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/rolling/utils/installer/install.sh)
