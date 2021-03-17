#!/bin/bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

installnodemac() { \
  brew install lua
  brew install node
  brew install yarn
}

installnodeubuntu() { \
  curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
  sudo apt-get install -y nodejs
  sudo apt install npm
  sudo npm cache clean -f
  sudo npm install -g n
  sudo n stable
}

installnodearch() { \
  sudo pacman -S nodejs
  sudo pacman -S npm
}

installnode() { \
  echo "Installing node..."
  [ "$(uname)" == "Darwin" ] && installnodemac
  [  -n "$(uname -a | grep Ubuntu)" ] && installnodeubuntu
  [ -f "/etc/arch-release" ] && installnodearch
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
  sudo npm i -g neovim
}

installpiponmac() { \
  sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py
  rm get-pip.py
}

installpiponubuntu() { \
  sudo apt --fix-broken install -y > /dev/null
  sudo apt-get install --fix-broken --assume-yes python3-pip > /dev/null
}

installpiponarch() { \
  pacman -S python-pip
}

installpip() { \
  echo "Installing pip..."
  [ "$(uname)" == "Darwin" ] && installpiponmac
  [  -n "$(uname -a | grep Ubuntu)" ] && installpiponubuntu
  [ -f "/etc/arch-release" ] && installpiponarch
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
}

installpynvim() { \
  echo "Installing pynvim..."
  pip3 install pynvim --user
}

installdeps() { \
  echo "Installing cmake..."
  [ "$(uname)" == "Darwin" ] && installcmakeonmac
  [ -n "$(uname -a | grep Ubuntu)" ] && installdepsonubuntu
  [ -f "/etc/arch-release" ] && installcmakeonarch
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
}

installdepsonubuntu(){
  echo "Installing cmake..."
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt install cmake libtool-bin lua5.4 gettext libgettextpo-dev -y > /dev/null
  pip install argparse
  installneovim
}

asktoinstalldeps() { \
  echo "dependencies for neovim not found"
  echo -n "Would you like to install cmake, lua5.4, libtool-bin now (y/n)? "
  read answer
  [ "$answer" != "${answer#[Yy]}" ] && installdeps
}

installneovim() { \
  echo "Installing neovim..."
  # install cmake
  which cmake > /dev/null && echo "neovim installed, moving on..." || asktoinstalldeps
  cd /tmp
  [ -d "neovim" ] && sudo rm -rf neovim
  git clone https://github.com/neovim/neovim
  cd neovim
  sudo make CMAKE_BUILD_TYPE=Release install
  cd /tmp
  sudo rm -r neovim
}

asktodelnvcode(){
  echo "nvcode folder found"
  echo -n "Would you like to delete folder now (y/n)? "
  read answer
  [ "$answer" != "${answer#[Yy]}" ] && delnvcode
}

delnvcode(){
 sudo rm -rf $HOME/.config/nvcode
 echo "delete nvcode folder done"
 cloneconfig
}

cloneconfig() { \
  echo "Cloning NVCode configuration"
  cd $HOME/.config
  [ -d "nvcode" ] && asktodelnvcode
  git clone https://github.com/mjcc30/nvcode.git $HOME/.config/nvcode
  echo "git nvcode done"
  nvim --headless +PackSync +qall > /dev/null 2>&1
  cd ~
  echo "cloneconfig done"
}

asktoinstallnode() { \
  echo "node not found"
  echo -n "Would you like to install node now (y/n)? "
  read answer
  [ "$answer" != "${answer#[Yy]}" ] && installnode
}

asktoinstallpip() { \
  echo "pip not found"
  echo -n "Would you like to install pip now (y/n)? "
  read answer
  [ "$answer" != "${answer#[Yy]}" ] && installpip
  exit
}

asktoinstallneovim() { \
  echo "neovim not found"
  echo -n "Would you like to install neovim now (y/n)? "
  read answer
  [ "$answer" != "${answer#[Yy]}" ] && installneovim 
}

installonmac() { \
  brew install ripgrep fzf ranger
}

pipinstallueberzug() { \
  which pip3 > /dev/null && pip3 install ueberzug || echo "Not installing ueberzug pip not found"
}

installonubuntu() { \
  sudo apt install ripgrep fzf ranger
  sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev
  pip3 install ueberzug
  pip3 install neovim-remote
}


installonarch() { \
  sudo pacman -S install ripgrep fzf ranger
  which yay > /dev/null && yay -S python-ueberzug-git || pipinstallueberzug
  pip3 install neovim-remote
}

installextrapackages() { \
  [ "$(uname)" == "Darwin" ] && installonmac
  [ -n "$(uname -a | grep Ubuntu)" ] && installonubuntu
  [ -f "/etc/arch-release" ] && installonarch
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && echo "Windows not currently supported"
}

baseInstall() { \
  # install pip
  which pip3 > /dev/null && echo "pip installed, moving on..." || asktoinstallpip
  # install node and neovim support
  which node > /dev/null && echo "node installed, moving on..." || asktoinstallnode
  # install neovim
  which nvim > /dev/null && echo "neovim installed, moving on..." || asktoinstallneovim
  # install pynvim
  pip3 list | grep pynvim > /dev/null && echo "pynvim installed, moving on..." || installpynvim
  which tree-sitter > /dev/null && sudo npm i -g tree-sitter-clir
  # clone config down
  cloneconfig

  echo 'export PATH=$HOME/.config/nvcode/utils/bin:$PATH' >> ~/.zshrc
  echo 'export PATH=$HOME/.config/nvcode/utils/bin:$PATH' >> ~/.bashrc
  source ~/.zshrc
  source ~/.bashrc

  echo "I recommend you also install and activate a font from here: https://github.com/ryanoasis/nerd-fonts"

  echo "I also recommend you add 'set preview_images_method ueberzug' to ~/.config/ranger/rc.conf"

  echo 'export PATH=$HOME/.config/nvcode/utils/bin:$PATH appending to zshrc/bashrc'
}

# Welcome
echo 'Installing NVCode'

baseInstall
