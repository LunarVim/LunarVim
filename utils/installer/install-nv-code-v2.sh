#!/bin/bash
# init

## ----------------------------------
# Descrtiption
# Maintainer: Maxime Cordeiro
#   - Help : List all commands
#   - Update
#   - Node Install
#   - Fresh Installation
## ----------------------------------

## ----------------------------------
# #1: Function init at the begining of script
## ----------------------------------
function pause(){
   read -p "$*"
}
## ----------------------------------
# #2: Constant
## ----------------------------------
server_name=$(hostname)
DIR="${PWD}"
USER_SCRIPT=$USER
args=("$@")
## ----------------------------------
# #3: Colors constant
## ----------------------------------
GREEN='\e[32m'
BLUE='\e[34m'
NOCOLOR='\e[0;m'
RED='\033[0;41;30m'
STD='\033[0;0;39m'
## ----------------------------------
# #4: Colors fonctions
## ----------------------------------
ColorGreen(){
	echo -ne $GREEN$1$NOCOLOR
}

ColorBlue(){
	echo -ne $BLUE$1$NOCOLOR
}
## ----------------------------------
# #5: Main functions
# ----------------------------------

## ----------------------------------
# Function : parse_options
# permit using argument ex: ./initscript.sh -h
# if no argument, interactif menu is starting
## ----------------------------------
parse_options() {
  case ${args[0]} in
    -h|--help)
      help_list
      exit
      ;;
    -u|--update)
      update
      ;;
    *)
      # CALL MENU
      menu
  esac
}

# -----------------------------------
# Menu - infinite loop for menu
# ------------------------------------
menu(){
clear
while true
do
	show_menus
	read_options
done
}

# -----------------------------------
# Menu - Screen
# ------------------------------------
show_menus(){
  clear
  echo "
            ~~~~~~~~~~~~~~~~~~~~~	
             - - - MENU - - -
            ~~~~~~~~~~~~~~~~~~~~~
  _________________________________________
 |     _   ___    ________           __     |
 |    / | / / |  / / ____/___   ____/ /__   |
 |   /  |/ /| | / / /   / __ \\ / __  / _ \\  |
 |  / /|  / | |/ / /___/ /_/ // /_/ /  __/  |
 | /_/ |_/  |___/\\\____/\___/\\\__,_/\\\___/  |
 |__________________________________________|

  $(ColorGreen '1)') Help : see commandes
  $(ColorGreen '2)') Update : Update your pc
  $(ColorGreen '3)') Nodejs : Install Nodejs
  $(ColorGreen 'i)') Init : freshInstall of Nvcode
  $(ColorGreen '0)') Exit"
}

# -----------------------------------
# Menu - Choice
# ------------------------------------
read_options(){
 local option
	  read -p "$(ColorBlue 'Choose option:') " option
    case $option in
      1) help_list ; menu ;;
      2) update ; menu ;;
      3) installnode ; menu ;;
      i) freshInstall ; menu ;;
      0) exit 0 ;;
      *) echo -e "${RED}Wrong option...${STD}" && sleep 1;  WrongCommand;;
    esac
}

# -----------------------------------
# Menu - Help
# ------------------------------------
help_list() {
  clear
  echo "How to use

  - Launch ./install-nv-code-v2.sh without arguments intercatif menu
  
  - You can also download script : 
    wget https://raw.githubusercontent.com/mjcc30/nvcode/master/utils/installer/install-nv-code-v2.sh
    Add execution : chmod +x install-nv-code-v2.sh
    And passe arguments like this :
    ./install-nv-code-v2.sh [-h]
    or
    ./install-nv-code-v2.sh [--help]

  Options:
    -h, --help
      see commands
    "
    pause 'Press [Enter] to continue...'
}

# -----------------------------------
# #6: Script functions
# ------------------------------------

function update(){
    #UPDATE
    clear
    echo "Update for Arch and Ubuntu users"
    if [ -n "$(uname -a | grep Ubuntu)" ]; then
      echo "Would you update you pc ? : 'Y' "
      read choice
      if [[ "$choice" ==  [yY] ]]; then
        sudo apt update && sudo apt upgrade -y
        clear
        echo "Update done with command :"
        echo
        echo "sudo apt update && sudo apt upgrade -y"
      fi
    fi
    if [ -f "/etc/arch-release" ]; then
      echo "Would you update you pc ? 'Y' "
      read choice
      if [[ "$choice" ==  [yY] ]]; then
        Sudo pacman -Syyu
        clear
        echo "Update done with command :"
        echo
        echo "Sudo pacman -Syyu"
      fi
    fi
    echo
    pause 'Press [Enter] to continue...'
}

installnode() { 
  echo "Installing Node..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Would you install Nodejs ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
      sudo apt-get install -y nodejs
      sudo apt install npm
      sudo npm cache clean -f
      sudo npm install -g n
      sudo n stable
    fi
  fi
  if [ "$(uname)" == "Darwin" ]; then
    echo "Would you install Nodejs ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      brew install lua
      brew install node
      brew install yarn
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Would you install Nodejs ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo pacman -S nodejs
      sudo pacman -S npm
    fi
  fi
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Would you install Nodejs ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      set dir=%cd% && "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command Start-Process '%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe' -ArgumentList '-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString(''https://chocolatey.org/install.ps1''));choco upgrade -y nodejs-lts ;  Read-Host ''Type ENTER to exit'' ' -Verb RunAs
    fi
  fi
 echo "Node install done"
 pause 'Press [Enter] to continue...'
}

installpip() { 
  echo "Installing pip..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Would you install pip ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo apt-get install --fix-broken --assume-yes python3-pip
    fi
  fi
  if [ "$(uname)" == "Darwin" ]; then
    echo "Would you install pip ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
      python3 get-pip.py
      rm get-pip.py
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Would you install pip ? :  'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo pacman -S python-pip
    fi
  fi
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Would you install pip ? :  'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "under construct"
    fi
  fi
  echo "pip install done"
  pause 'Press [Enter] to continue...'
}

installneovim(){
  echo "Installing neovim 0.5 ..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Would you install neovim 0.5 ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
       which cmake > /dev/null && echo "neovim installed, moving on..." || installdepsforneovim
       cd /tmp
       [ -d "neovim" ] && sudo rm -rf neovim
       git clone https://github.com/neovim/neovim
       cd neovim
       sudo make CMAKE_BUILD_TYPE=Release install
       cd /tmp
       sudo rm -r neovim
    fi
  fi
  if [ "$(uname)" == "Darwin" ]; then
    echo "Would you install neovim 0.5 ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      which cmake > /dev/null && echo "neovim installed, moving on..." || installdepsforneovim
      cd /tmp
      [ -d "neovim" ] && sudo rm -rf neovim
      git clone https://github.com/neovim/neovim
      cd neovim
      sudo make CMAKE_BUILD_TYPE=Release install
      cd /tmp
      sudo rm -r neovim
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Would you install neovim 0.5 ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      which cmake > /dev/null && echo "neovim installed, moving on..." || installdepsforneovim
      cd /tmp
      [ -d "neovim" ] && sudo rm -rf neovim
      git clone https://github.com/neovim/neovim
      cd neovim
      sudo make CMAKE_BUILD_TYPE=Release install
      cd /tmp
      sudo rm -r neovim
    fi
  fi
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Would you install neovim 0.5 ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "under construct"
    fi
  fi
  echo "neovim install done"
  pause 'Press [Enter] to continue...'
}

installdepsforneovim(){
 echo "Installing neovim dependencies..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Would you install neovim dependencies  ? : 'Y' "
    echo "This will install cmake libtool-bin lua5.3 gettext libgettextpo-dev argparse"
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo apt-get update
      sudo apt-get upgrade
      sudo apt install cmake libtool-bin lua5.3 gettext libgettextpo-dev -y > /dev/null
      pip install argparse
    fi
  fi
  if [ "$(uname)" == "Darwin" ]; then
    echo "Would you install neovim dependencies  ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "Under construct"
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Would you install neovim dependencies  ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "Under construct"
    fi
  fi
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Would you install neovim dependencies ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "Under construct"
    fi
  fi
  echo "neovim dependencies install done"
  pause 'Press [Enter] to continue...'
}

installgit(){
 echo "Installing git..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Would you install Git ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo apt-get install git
    fi
  fi
  if [ "$(uname)" == "Darwin" ]; then
    echo "Would you install Git ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "Under construct"
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Would you install Git ? : 'Y'"
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo pacman -S git
    fi
  fi
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Would you install Git ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      set dir=%cd% && "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command Start-Process '%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe' -ArgumentList '-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString(''https://chocolatey.org/install.ps1''));choco upgrade -y git --params "/GitAndUnixToolsOnPath /NoAutoCrlf";  Read-Host ''Type ENTER to exit'' ' -Verb RunAs
    fi
  fi
  echo "git install done"
  pause 'Press [Enter] to continue...'
}

function freshInstall(){
  clear
  echo
  echo " Welcome to fresh installation of NVCODE  !!!" 
  echo "Would you start ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    update
    which node > /dev/null && echo "node installed, moving on..." || installnode
    which pip3 > /dev/null && echo "pip installed, moving on..." || installpip
    which cmake > /dev/null && echo "cmake installed, moving on..." || installdepsforneovim
    which nvim > /dev/null && echo "neovim installed, moving on..." || installneovim
    pip3 list | grep pynvim > /dev/null && echo "pynvim installed, moving on..." || pip3 install pynvim --user
    which tree-sitter > /dev/null && sudo npm i -g tree-sitter-cli
    which tree-sitter > /dev/null && sudo npm i -g neovim
    cloneconfig
    nvim --headless +PackSync +qall > /dev/null 2>&1
    [ -f "~/.bashrc" ] && echo 'export PATH=$HOME/.config/nvcode/utils/bin:$PATH' >> ~/.bashrc && source ~/.bashrc
    [ -f "~/.zshrc" ] &&  echo 'export PATH=$HOME/.config/nvcode/utils/bin:$PATH' >> ~/.zshrc && source ~/.zshrc
  fi
 echo "Nvcode install done"
 pause 'Press [Enter] to continue...'
}

installextrapackages() {
 echo "Extra packages for Nvcode..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Would you install extra packages ? : 'Y' "
    echo "This will install ripgrep fzf ranger libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev ueberzug neovim-remote"
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo apt install ripgrep fzf ranger
      sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev
      pip3 install ueberzug
      pip3 install neovim-remote
    fi
  fi
  if [ "$(uname)" == "Darwin" ]; then
    echo "Would you install extra packages ? : 'Y' "
    echo "This will install ripgrep fzf ranger "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      brew install ripgrep fzf ranger
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Would you install extra packages ? : 'Y' "
    echo "This will install ripgrep fzf ranger python-ueberzug-git neovim-remote "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo pacman -S install ripgrep fzf ranger
      which yay > /dev/null && yay -S python-ueberzug-git || pipinstallueberzug
      pip3 install neovim-remote
    fi
  fi
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Would you install extra packages ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "Under construct"
    fi
  fi
 echo "Extra packages install done"
 pause 'Press [Enter] to continue...'
}

## ----------------------------------
# #7: Extra Fonction
## ----------------------------------

pipinstallueberzug() { \
  which pip3 > /dev/null && pip3 install ueberzug || echo "Not installing ueberzug => pip not found"
}

cloneconfig() { \
  echo "Cloning NVCode configuration"
  cd ~/.config
  [ -d "nvcode" ] && asktodelnvcode
  git --version > /dev/null && git clone https://github.com/mjcc30/nvcode.git ~/.config/nvcode || installgit
  echo "git nvcode done"
  cd ~
  echo "cloneconfig done"
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

## ----------------------------------
# #8: Fonction launch by the script
## ----------------------------------
parse_options $@
