#!/bin/bash
# init

## ----------------------------------
# Descrtiption du script
# Auteur: Maxime Cordeiro
#   - Aide : affiche les commandes possible
#   - Mise à jour du system
#   - Installation : installation de Nvcode
## ----------------------------------

## ----------------------------------
# #1: Fonction initialiser au debut du script
## ----------------------------------
function pause(){
   read -p "$*"
}

## ----------------------------------
# #2: Constantes
## ----------------------------------
server_name=$(hostname)
DIR="${PWD}"
USER_SCRIPT=$USER
args=("$@")
## ----------------------------------
# #3: Constantes couleurs
## ----------------------------------
GREEN='\e[32m'
BLUE='\e[34m'
NOCOLOR='\e[0;m'
RED='\033[0;41;30m'
STD='\033[0;0;39m'

## ----------------------------------
# #4: Fonction couleurs
## ----------------------------------

ColorGreen(){
	echo -ne $GREEN$1$NOCOLOR
}

ColorBlue(){
	echo -ne $BLUE$1$NOCOLOR
}

## ----------------------------------
# #5: Fonctions Principales
# ----------------------------------

## ----------------------------------
# Fonction : parse_options
# permet l'utilisation d'argument ex: ./initscript.sh -h
# si aucun argument on lance le menu interactif
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
      # APPELLE DU MENU
      menu
  esac
}

# -----------------------------------
# Menu - Boucle infini
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
# Menu - Affichage
# ------------------------------------
show_menus(){
  clear
  echo "
            ~~~~~~~~~~~~~~~~~~~~~	
             - - - NVCODE - - -
            ~~~~~~~~~~~~~~~~~~~~~
  _________________________________________
 |     _   ___    ________           __     |
 |    / | / / |  / / ____/___   ____/ /__   |
 |   /  |/ /| | / / /   / __ \\ / __  / _ \\  |
 |  / /|  / | |/ / /___/ /_/ // /_/ /  __/  |
 | /_/ |_/  |___/\\\____/\___/\\\__,_/\\\___/  |
 |__________________________________________|

  $(ColorGreen '1)') Aide : affiche les commandes possible
  $(ColorGreen '2)') Update : Mettre a jour votre pc
  $(ColorGreen '3)') Nodejs : Installer Nodejs
  $(ColorGreen '4)') Init : script initialisation pour une freshInstall
  $(ColorGreen '0)') Quitter"
}

# -----------------------------------
# Menu - Choix
# ------------------------------------
read_options(){
 local option
	  read -p "$(ColorBlue 'Choisir une option:') " option
    case $option in
      1) help_list ; menu ;;
      2) update ; menu ;;
      3) installnode ; menu ;;
      4) freshInstall ; menu ;;
		  0) exit 0 ;;
		  *) echo -e "${RED}Mauvaise option...${STD}" && sleep 1;  WrongCommand;;
    esac
}

# -----------------------------------
# Menu - Help
# ------------------------------------
help_list() {
  clear
  echo "Utilisation

  Lancer ./${0##*/} sans arguments pour passer par le menu intercatif
  ou 
  ./${0##*/} [-h]
  ou
  ./${0##*/} [--help]

  Options:

    -h, --help
      affiche les commandes possible
    "
    pause 'Presse [Entrer] pour continuer...'
}

# -----------------------------------
# #6: Les Fonctions du script
# ------------------------------------

function update(){
    #MISE A JOUR
    clear
    echo
    if [ -n "$(uname -a | grep Ubuntu)" ]; then
      echo "Voulez vous faire les mise à jour ? : si oui répondre avec la touche 'Y' "
      read choice
      if [[ "$choice" ==  [yY] ]]; then
        sudo apt update && sudo apt upgrade -y
        clear
        echo "La mise à jour à était effectuer avec la commande suivante :"
        echo
        echo "sudo apt update && sudo apt upgrade -y"
        echo
        pause 'Presse [Entrer] pour continuer...'
      fi
    fi
    if [ -f "/etc/arch-release" ]; then
      echo "Voulez vous faire les mise à jour ? : si oui répondre avec la touche 'Y' "
      read choice
      if [[ "$choice" ==  [yY] ]]; then
        Sudo pacman -Syyu
        clear
        echo "La mise à jour à était effectuer avec la commande suivante :"
        echo
        echo "Sudo pacman -Syyu"
        echo
        pause 'Presse [Entrer] pour continuer...'
      fi
    fi
}

installnode() { 
  echo "Installation de node..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Voulez vous faire les mise à jour ? : si oui répondre avec la touche 'Y' "
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
    echo "Voulez vous faire les mise à jour ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      brew install lua
      brew install node
      brew install yarn
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Voulez vous faire les mise à jour ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo pacman -S nodejs
      sudo pacman -S npm
    fi
  fi
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Voulez vous faire les mise à jour ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      set dir=%cd% && "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command Start-Process '%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe' -ArgumentList '-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString(''https://chocolatey.org/install.ps1''));choco upgrade -y nodejs-lts ;  Read-Host ''Type ENTER to exit'' ' -Verb RunAs
    fi
  fi
 echo "Node est installé"
 pause 'Presse [Entrer] pour continuer...'
}

installpip() { 
  echo "Installation de pip..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Voulez vous Installer pip ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo apt-get install --fix-broken --assume-yes python3-pip
    fi
  fi
  if [ "$(uname)" == "Darwin" ]; then
    echo "Voulez vous installer pip ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
      python3 get-pip.py
      rm get-pip.py
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Voulez vous pip ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo pacman -S python-pip
    fi
  fi
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Voulez vous pip ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "under construct"
    fi
  fi
  echo "pip est installé"
  pause 'Presse [Entrer] pour continuer...'
}

installneovim(){
  echo "Installation de neovim 0.5 ..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Voulez vous Installer neovim 0.5 ? : si oui répondre avec la touche 'Y' "
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
    echo "Voulez vous installer neovim 0.5 ? : si oui répondre avec la touche 'Y' "
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
    echo "Voulez vous installer neovim 0.5 ? : si oui répondre avec la touche 'Y' "
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
    echo "Voulez vous installer neovim 0.5 ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "under construct"
    fi
  fi
  echo "neovim est installer"
  pause 'Presse [Entrer] pour continuer...'
}

installdepsforneovim(){
 echo "Installation de dependence pour neovim..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Voulez vous installer  ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo apt-get update
      sudo apt-get upgrade
      sudo apt install cmake libtool-bin lua5.4 gettext libgettextpo-dev -y > /dev/null
      pip install argparse
    fi
  fi
  if [ "$(uname)" == "Darwin" ]; then
    echo "Voulez vous installer pip ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "NOK"
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Voulez vous pip ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "NOK"
    fi
  fi
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Voulez vous pip ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "NOK"
    fi
  fi
  echo "les deépendences pour l'installation de neovim sont installées"
  pause 'Presse [Entrer] pour continuer...'
}

installgit(){
 echo "Installation de git..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Voulez vous installer Git ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo apt-get install git
    fi
  fi
  if [ "$(uname)" == "Darwin" ]; then
    echo "Voulez vous installer pip ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "NOK"
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Voulez vous pip ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo pacman -S git
    fi
  fi
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Voulez vous pip ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      set dir=%cd% && "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command Start-Process '%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe' -ArgumentList '-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString(''https://chocolatey.org/install.ps1''));choco upgrade -y git --params "/GitAndUnixToolsOnPath /NoAutoCrlf";  Read-Host ''Type ENTER to exit'' ' -Verb RunAs
    fi
  fi
  echo "git est installé"
  pause 'Presse [Entrer] pour continuer...'
}

function freshInstall(){
  init= "true"
  clear
  echo
  echo " Bienvenu  dans L'installation de NVCODE  !!!" 
  echo "Voulez vous commencer ? : si oui répondre avec la touche 'Y' "
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
 echo "L'installation de Nvcode est terminé"
 pause 'Presse [Entrer] pour continuer...'
}

installextrapackages() {
 echo "Installation de paquet extra pour Nvcode..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Voulez vous installer ripgrep,fzf,ranger,etc ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo apt install ripgrep fzf ranger
      sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev
      pip3 install ueberzug
      pip3 install neovim-remote
    fi
  fi
  if [ "$(uname)" == "Darwin" ]; then
    echo "Voulez vous installer ripgrep,fzf,ranger ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      brew install ripgrep fzf ranger
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Voulez vous installer ripgrep,fzf,ranger ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo pacman -S install ripgrep fzf ranger
      which yay > /dev/null && yay -S python-ueberzug-git || pipinstallueberzug
      pip3 install neovim-remote
    fi
  fi
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Voulez vous ripgrep,fzf,ranger ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      echo "NOK"
    fi
  fi
 echo "l'installation des paquets extra est terminé"
 pause 'Presse [Entrer] pour continuer...'
}

## ----------------------------------
# #7: Extra Fonction
## ----------------------------------

pipinstallueberzug() { \
  which pip3 > /dev/null && pip3 install ueberzug || echo "Not installing ueberzug pip not found"
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
# #8: Fonction lancé par le script
## ----------------------------------
parse_options $@
