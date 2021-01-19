#!/bin/bash

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

installcocextensions() {
  # Install extensions
  mkdir -p ~/.config/coc/extensions
  cd ~/.config/coc/extensions
  [ ! -f package.json ] && echo '{"dependencies":{}}' >package.json
  # Change extension names to the extensions you need
  EXTENSIONS="coc-snippets coc-actions coc-sh coc-bookmark@1.2.6 coc-lists coc-emmet coc-tasks coc-pairs coc-tsserver coc-floaterm coc-fzf-preview coc-html coc-css coc-cssmodules coc-stylelintplus coc-yaml coc-python coc-pyright coc-explorer coc-svg coc-prettier coc-vimlsp coc-xml coc-yank coc-json coc-marketplace coc-eslint coc-floaterm coc-diagnostic coc-go coc-gitignore coc-git coc-markdownlint coc-webpack coc-docker coc-styled-components coc-github coc-react-refactor coc-docthis coc-tabnine coc-gist"
  sudo npm i ${EXTENSIONS} --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod --legacy-peer-deps
}

cloneconfig() {
  echo "Cloning neovim configuration."
  git clone git@github.com:cenk1cenk2/nvim.git ~/.config/nvim
}

moveoldnvim() {
  echo "Moving your config to nvim.old"
  mv $HOME/.config/nvim $HOME/.config/nvim.old
}

moveoldcoc() {
  echo "Moving your coc to coc.old"
  mv $HOME/.config/coc $HOME/.config/coc.old
}

installplugins() {
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.tmp
  mv $HOME/.config/nvim/utils/init.vim $HOME/.config/nvim/init.vim
  echo "Installing plugins..."
  nvim --headless +PlugInstall +qall >/dev/null 2>&1
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/utils/init.vim
  mv $HOME/.config/nvim/init.vim.tmp $HOME/.config/nvim/init.vim
}

asktoinstallnode() {
  echo "node not found"
  echo -n "Would you like to install node now (y/n)? "
  read answer
  [ "$answer" != "${answer#[Yy]}" ] && installnode && installcocextensions
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
}

pipinstallueberzug() {
  which pip3 >/dev/null && pip3 install ueberzug || echo "Not installing ueberzug pip not found"
}

installonubuntu() {
  sudo apt install ripgrep fzf ranger
  sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev
  pip3 install ueberzug
  pip3 install neovim-remote
}

installonarch() {
  sudo pacman -S install ripgrep fzf ranger
  which yay >/dev/null && yay -S python-ueberzug-git || pipinstallueberzug
  pip3 install neovim-remote
}

installextrapackages() {
  [ "$(uname)" == "Darwin" ] && installonmac
  [ -n "$(uname -a | grep Ubuntu)" ] && installonubuntu
  [ -f "/etc/arch-release" ] && installonarch
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
}

# Welcome
echo 'Installing Nvim configuration.'

# install pynvim
pip3 list | grep pynvim >/dev/null && echo "pynvim installed, moving on..." || installpynvim

# move old nvim directory if it exists
[ -d "$HOME/.config/nvim" ] && moveoldnvim

# move old nvim directory if it exists
[ -d "$HOME/.config/coc" ] && moveoldcoc

# clone config down
cloneconfig

# echo "Nvim Mach 2 is better with at least ripgrep, ueberzug and ranger"
# echo -n "Would you like to install these now?  (y/n)? "
# read answer
# [ "$answer" != "${answer#[Yy]}" ] && installextrapackages || echo "not installing extra packages"

# install plugins
which nvim >/dev/null && installplugins

installcocextensions
