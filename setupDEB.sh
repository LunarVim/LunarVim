#!/bin/sh

# installing neovim
sudo apt install -y neovim

# needed to pull installer
sudo apt install -y curl

# used for clipboard
sudo apt install -y xsel

# pul sown installer
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh

# run installer
sh ./installer.sh ~/.cache/dein

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

~/.fzf/install
