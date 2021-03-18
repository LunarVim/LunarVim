#!/bin/bash
# init

## ----------------------------------
# Descrtiption
# Maintainer: Maxime Cordeiro
#   - Help : List all commands
#   - Update
#   - Node Install
#   - Fresh Installation
#   - Extra packages for Nvcode
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
    -i|--init)
      freshInstall
      ;;
    -n|--node)
      installnode
      ;;
    -e|--extra)
      installextrapackages
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

  $(ColorGreen 'i)') Init : Fresh install of Nvcode
  $(ColorGreen '1)') Help : see commands
  $(ColorGreen '2)') Update : Update your pc
  $(ColorGreen '3)') Nodejs : Install Nodejs
  $(ColorGreen '4)') Extra : Install Extra package for Nvcode
  $(ColorGreen '0)') Exit"
}

# -----------------------------------
# Menu - Choice
# ------------------------------------
read_options(){
 local option
	  read -p "$(ColorBlue 'Choose option:') " option
    case $option in
      i) freshInstall ; menu ;;
      1) help_list ; menu ;;
      2) update ; menu ;;
      3) installnode ; menu ;;
      4) installextrapackages ; menu ;;
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
    -i, --init
      Run fresh Nvcode installation
    -n, --node
      Run Node installation
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
  clear
  echo "Installing Nodejs..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Would you install Nodejs with nvm ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      which curl > /dev/null && curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash - || sudo apt install curl -y && curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
      sudo timedatectl set-local-rtc 1
      node -v > /dev/null || sudo apt-get install -y nodejs
      npm -v > /dev/null && echo "npm installed, moving on" || sudo apt install npm -y
      npm -v > /dev/null && sudo npm install latest || sudo apt install npm -y
      npm -v > /dev/null && sudo npm cache clean -f || sudo apt install npm -y
      npm -v > /dev/null && sudo npm install -g n || sudo apt install npm -y
      sudo timedatectl set-local-rtc 0
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
  clear
  echo "Installing pip..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Would you install pip ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo apt-get install --fix-broken --assume-yes python3-pip -y
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
  clear
  echo "Installing neovim 0.5 ..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Would you install neovim 0.5 ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
       which cmake > /dev/null && echo "cmake installed, moving on..." || installdepsforneovim
       cd /tmp
       [ -d "neovim" ] && sudo rm -rf neovim
       which git > /dev/null && git clone https://github.com/neovim/neovim || sudo apt-get install git -y
       [ -d "neovim" ] && cd neovim || git clone https://github.com/neovim/neovim && cd neovim
       sudo make CMAKE_BUILD_TYPE=Release install
       cd ..
       [ -d "neovim" ] && sudo rm -r neovim
    fi
  fi
  if [ "$(uname)" == "Darwin" ]; then
    echo "Would you install neovim 0.5 ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      which cmake > /dev/null && echo "cmake installed, moving on..." || installdepsforneovim
      cd /tmp
      [ -d "neovim" ] && sudo rm -rf neovim
      which git > /dev/null && git clone https://github.com/neovim/neovim || sudo apt-get install git -y
      cd neovim
      sudo make CMAKE_BUILD_TYPE=Release install
      cd ..
      [ -d "neovim" ] && sudo rm -r neovim
    fi
  fi
  if [ -f "/etc/arch-release" ]; then
    echo "Would you install neovim 0.5 ? : si oui répondre avec la touche 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      which cmake > /dev/null && echo "cmake installed, moving on..." || installdepsforneovim
      cd /tmp
      [ -d "neovim" ] && sudo rm -rf neovim
      which git > /dev/null && git clone https://github.com/neovim/neovim || sudo apt-get install git -y
      cd neovim
      sudo make CMAKE_BUILD_TYPE=Release install
      cd ..
      [ -d "neovim" ] && sudo rm -r neovim
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
 clear
 echo "Installing neovim dependencies..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Would you install neovim dependencies  ? : 'Y' "
    echo "This will install cmake libtool-bin lua5.3 gettext libgettextpo-dev argparse"
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      sudo apt-get update
      sudo apt-get upgrade -y
      sudo apt install cmake libtool-bin lua5.3 gettext libgettextpo-dev -y > /dev/null
      which pip3 > /dev/null && pip3 install argparse || installpip
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
 clear
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
    npm list -g tree-sitter-cli > /dev/null && echo "tree-sitter-cli node module installed, moving on..." || sudo npm i -g tree-sitter-cli --unsafe-perm
    npm list -g express > /dev/null && echo "neovim node module istalled, moving on..." || sudo npm i -g neovim
    cloneconfig
  fi
  exec bash
}

cloneconfig() { 
  clear
  echo "Cloning NVCode configuration"
  echo "Would you install nvcode, which version ? : 'Y' "
  echo "1: master"
  echo "2: stable-lsp"
  echo "3: stable-coc"
  echo "other: exit"
  read choice
  cd ~/.config
  if [[ "$choice" ==  [1] ]]; then
  [ -d "nvcode" ] && asktodelnvcode
  git --version > /dev/null && git clone https://github.com/mjcc30/nvcode.git ~/.config/nvcode || installgit
  nvim --headless +PackSync +qall > /dev/null 2>&1
  cd $HOME
  [ -f ".bashrc" ] && echo 'export PATH=$HOME/.config/nvcode/utils/bin:$PATH' >> ~/.bashrc && source ~/.bashrc
  [ -f ".zshrc" ] &&  echo 'export PATH=$HOME/.config/nvcode/utils/bin:$PATH' >> ~/.zshrc && source ~/.zshrc
  nvim -es -c ':PackerInstall' -u ~/.config/nvcode/init.lua
  nvim -es -c ':PackerUpdate' -u ~/.config/nvcode/init.lua
  nvim -es -u ~/.config/nvcode/init.lua
  clear
  echo "Nvcode install done"
  echo
  echo "After please run 'nv' and do ':PackerInstall' and ':UpdateRemotePlugins' inside nv"
  fi
  if [[ "$choice" ==  [2] ]]; then
  [ -d "nvim" ] && asktodelnvcode
  git --version > /dev/null && git clone https://github.com/mjcc30/nvcode.git ~/.config/nvim || installgit
  cd nvim
  git checkout stable-snapshot-Native-LSP-1
  git pull
  clear
  echo "git nvim stable-lsp done"
  echo "Now you can run 'nvim' and do ':UpdateRemotePlugins' inside nvim"
  fi
  if [[ "$choice" ==  [3] ]]; then
  [ -d "nvim" ] && asktodelnvcode
  git --version > /dev/null && git clone https://github.com/mjcc30/nvcode.git ~/.config/nvim || installgit
  cd nvim
  git checkout stable-snapshot-CoC
  git pull
  clear
  echo "git nvim stable-coc done"
  echo "Now you can run 'nvim' and do ':UpdateRemotePlugins' inside nvim"
  fi
  cd ~
  pause 'Press [Enter] to continue...'
}

installextrapackages() {
 clear
 echo "Extra packages for Nvcode..."
  if [ -n "$(uname -a | grep Ubuntu)" ]; then
    echo "Would you install extra packages ? : 'Y' "
    read choice
    if [[ "$choice" ==  [yY] ]]; then
      aptextrapackages
      npmextrapackages
      pipextrapackages
      clear
      echo "lua-language-server installation"
      cd $HOME/.config
      [ -d "nvim" ] && cd nvim || echo "nvim folder not found"
      [ -d "nvcode" ] && cd nvcode || echo "nvcode folder not found"
      git clone https://github.com/sumneko/lua-language-server
      cd lua-language-server
      git submodule update --init --recursive
      cd 3rd/luamake
      ninja -f ninja/linux.ninja
      cd ../..
      ./3rd/luamake/luamake rebuild
      cd
      pause 'Press [Enter] to continue...'
      clear
      echo "luarocks installation"
      wget https://luarocks.org/releases/luarocks-3.3.1.tar.gz
      tar zxpf luarocks-3.3.1.tar.gz
      cd luarocks-3.3.1
      ./configure --with-lua-include=/usr/local/include
      make
      cd
      luarocks install --server=https://luarocks.org/dev luaformatter
      pause 'Press [Enter] to continue...'
      clear
      echo "luarocks installation"
      wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
      [ -f ".bashrc" ] && echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
      [ -f ".zshrc" ] && echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
      [ -f ".bashrc" ] && echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc && source ~/.bashrc
      [ -f ".zshrc" ] &&  echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.zshrc && source ~/.zshrc
      source ~/.profile
      echo "go is installed we have to reload the terminal"
      echo "please copy the following command to install efm-langserver:"
      echo "go get github.com/mattn/efm-langserver"
      pause 'Press [Enter] to continue...'
      exec bash
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

aptextrapackages() {
  clear
  echo "ripgrep fzf ranger libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev ninja-build"
  list=("ripgrep" "fzf" "ranger" "libjpeg8-dev" "zlib1g-dev" "python-dev" "python3-dev" "libxtst-dev" "ninja-build")
  menuitems() {
    for i in ${!list[@]}; do
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${list[i]}"
    done
  }

  while menuitems && read -rp "choose a package: " num && [[ "$num" ]]; do
    clear
    [[ "$num" != *[![:digit:]]* ]] && (( num > 0 && num <= ${#list[@]} )) || continue
    ((num--));
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="x"
  done
  echo "apt packages installation"
  sudo add-apt-repository ppa:lazygit-team/release
  sudo apt-get update
  for i in ${!list[@]}; do
    [[ "${choices[i]}" ]] && { sudo apt install -y "${list[i]}"; }
  done
  echo "Extra packages install done"
  pause 'Press [Enter] to continue...'
}

npmextrapackages() {
  clear
  echo "npm packages installation"
  echo "vscode-html-languageserver-bin typescript typescript-language-server pyright bash-language-server vscode-css-languageserver-bin dockerfile-language-server-nodejs vim-language-server yaml-language-server graphql-language-service-cli vscode-json-languageserver"
  list=("vscode-html-languageserver-bin" "typescript" "typescript-language-server" "pyright" "bash-language-server" "vscode-css-languageserver-bin" "dockerfile-language-server-nodejs" "vim-language-server" "yaml-language-server" "graphql-language-service-cli" "vscode-json-languageserver")
  menuitems() {
    for i in ${!list[@]}; do
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${list[i]}"
    done
  }

  while menuitems && read -rp "choose a package: " num && [[ "$num" ]]; do
    clear
    [[ "$num" != *[![:digit:]]* ]] && (( num > 0 && num <= ${#list[@]} )) || continue
    ((num--));
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="x"
  done
  echo "npm packages installation"
  for i in ${!list[@]}; do
    [[ "${choices[i]}" ]] && { sudo npm i -g "${list[i]}"; }
  done
  echo "Extra packages install done"
 pause 'Press [Enter] to continue...'
}

pipextrapackages() {
  clear
  echo "pip3 packages installation"
  echo "ueberzug neovim-remote fd"
  list=("ueberzug" "neovim-remote" "fd")
  menuitems() {
    for i in ${!list[@]}; do
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${list[i]}"
    done
  }

  while menuitems && read -rp "choose a package: " num && [[ "$num" ]]; do
    clear
    [[ "$num" != *[![:digit:]]* ]] && (( num > 0 && num <= ${#list[@]} )) || continue
    ((num--));
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="x"
  done
  echo "pip3 packages installation"
  for i in ${!list[@]}; do
    [[ "${choices[i]}" ]] && { sudo pip3 install "${list[i]}"; }
  done
  echo "Extra packages install done"
  pause 'Press [Enter] to continue...'
}

## ----------------------------------
# #7: Extra Fonction
## ----------------------------------

pipinstallueberzug() {
  which pip3 > /dev/null && pip3 install ueberzug || echo "Not installing ueberzug => pip not found"
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

asktodelnvim(){
  echo "nvim folder found"
  echo -n "Would you like to delete folder now (y/n)? "
  read answer
  [ "$answer" != "${answer#[Yy]}" ] && delnvim
}

delnvim(){
 sudo rm -rf $HOME/.config/nvim
 echo "delete nvim folder done"
 cloneconfig
}
## ----------------------------------
# #8: Fonction launch by the script
## ----------------------------------
parse_options $@
