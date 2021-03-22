#!/bin/bash
# init

## ----------------------------------
# Descrtiption
# Maintainer: Maxime Cordeiro
#   - Help : List all commands using argument ex: ./initscript.sh -h
#   - Fresh Installation
#   - Update
#   - Node Install
#   - Git Install
#   - Pip Install
#   - Neovim Install
#   - Nvcode Install
#   - Extra packages for Nvcode
#   - Nerd-font Installation
## ----------------------------------

## ----------------------------------
# #1: Function init at the begining of script
## ----------------------------------
function pause(){
   read -p "$*"
}

function findarch() {
  [ -n "$(uname -a | grep Ubuntu)" ] && ARCH="Ubuntu"
  [ "$(uname)" == "Darwin" ] && ARCH="Darwin"
  [ -f "/etc/arch-release" ] && ARCH="Archlinux"
  [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ] && ARCH="Windows"
}

findarch

## ----------------------------------
# #2: Constant
## ----------------------------------
args=("$@")
URL="https://github.com/ChristianChiarulli/nvcode.git"
install=0
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
    -f|--font)
      installnerdfont
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
  $(ColorGreen '4)') Git : Install Git
  $(ColorGreen '5)') Pip : Install Pip
  $(ColorGreen '6)') Neovim : Install Neovim
  $(ColorGreen '7)') Nvcode: Get Nvcode
  $(ColorGreen '8)') Extra : Install Extra package for Nvcode
  $(ColorGreen '9)') Extra : Install Nerd fonts for Nvcode
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
      4) installgit ; menu ;;
      5) installpip ; menu ;;
      6) installneovim ; menu ;;
      7) cloneconfig ; menu ;;
      8) installextrapackages ; menu ;;
      9) installnerdfont ; menu ;;
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
freshInstall(){
  clear
  echo
  echo " Welcome to fresh installation of NVCODE  !!!" 
  echo "Would you start ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    update
    which node > /dev/null && echo "node installed, moving on..." || installnode
    which pip3 > /dev/null && echo "pip installed, moving on..." || installpip
    installdepsforneovim
    nvim -v | grep v0.5 > /dev/null && echo "nvim 0.5 installed, moving on..." || installneovim
    pip3 list | grep pynvim > /dev/null && echo "pynvim installed, moving on..." || pip3 install pynvim --user
    if [[ "$ARCH" ==  "Archlinux" ]]; then
      which tree-sitter > /dev/null && echo "tree-sitter  installed, moving on..." || sudo npm i -g tree-sitter-cli --unsafe-perm
    else
      npm list -g tree-sitter-cli > /dev/null && echo "tree-sitter-cli node module installed, moving on..." || sudo npm i -g tree-sitter-cli --unsafe-perm
    fi
    npm list -g neovim > /dev/null && echo "neovim node module istalled, moving on..." || sudo npm i -g neovim
    installextrapackages
    cloneconfig
  fi
  exec bash
}

function update(){
  clear
  echo "Update for Arch and Ubuntu users"
  echo "Would you update you pc ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    case "${ARCH}" in
      "Ubuntu")
        sudo apt update && sudo apt upgrade -y && echo "update done"
      ;;
      "Archlinux")
        sudo pacman -Syyu && echo "update done"
      ;;
      *)
        echo "This script don't know your distro yet"
        echo "Please update manually"
      ;;
    esac
    echo
    echo "If update failed please close, reopen terminal and rerun the script or update manually "
    pause 'Press [Enter] to continue...'
  fi
}

installnode() {
  clear
  echo "Installing Nodejs..."
  echo "Would you install Nodejs with nvm ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    case "${ARCH}" in
      "Ubuntu")
        which curl > /dev/null && curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash - || sudo apt install curl -y && curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
        sudo timedatectl set-local-rtc 1
        node -v > /dev/null || sudo apt-get install -y nodejs
        npm -v > /dev/null && echo "npm installed, moving on" || sudo apt install npm -y
        npm -v > /dev/null && sudo npm install npm@latest -g || sudo apt install npm -y
        npm -v > /dev/null && sudo npm cache clean -f || sudo apt install npm -y
        npm -v > /dev/null && sudo npm install -g n || sudo apt install npm -y
        sudo timedatectl set-local-rtc 0
      ;;
      "Darwin")
        brew install lua
        brew install node
        brew install yarn
      ;;
      "Archlinux")
        sudo pacman -S nodejs
        sudo pacman -S npm
      ;;
      "Windows")
        echo
        echo "for install node in command line run copy and past the following line in cmd"
        echo "or you can download it from the site : https://nodejs.org/en/download/"
        echo
        echo "this will install nodejs from chocolatey :"
        echo
        echo `set dir=%cd% && "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command Start-Process '%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe' -ArgumentList '-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString(''https://chocolatey.org/install.ps1''));choco upgrade -y nodejs-lts ;  Read-Host ''Type ENTER to exit'' ' -Verb RunAs`
        pause 'Press [Enter] to continue...'
      ;;
      *)
        echo "This script don't know your distro yet"
        echo "Please install node and npm manually"
        echo "https://nodejs.org/en/download/"
      ;;
    esac
    pause 'Press [Enter] to continue...'
  fi
}

installpip() { 
  clear
  echo "Installing pip..."
  echo "Would you install pip ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    case "${ARCH}" in
      "Ubuntu")
        sudo apt-get install --fix-broken --assume-yes python3-pip -y
      ;;
      "Darwin")
        sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python3 get-pip.py
        rm get-pip.py
      ;;
      "Archlinux")
        sudo pacman -S python-pip
      ;;
      "Windows")
        echo
        echo "for install python and pip in command line run copy and past the following line in cmd"
        echo "or you can download the Windows installer version from the site : https://www.python.org/downloads/windows/"
        ech " you need to have python installed to install pip"
        echo
        echo "this line will install python from chocolatey copy and paste to cmd :"
        echo
        echo `set dir=%cd% && "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command Start-Process '%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe' -ArgumentList '-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString(''https://chocolatey.org/install.ps1''));choco upgrade -y python ;  Read-Host ''Type ENTER to exit'' ' -Verb RunAs`
        echo
        pause 'Press [Enter] to continue...'
        curl -sO https://bootstrap.pypa.io/get-pip.py
        which py > /dev/null && py get-pip.py || echo "python not found"
        which py > /dev/null && py -m pip install --upgrade pip || echo "python not found"
      ;;
      *)
        echo "This script don't know your distro yet"
        echo "Please instal python and pip manually"
        echo "python : https://www.python.org/downloads/"
        echo "pip : https://pip.pypa.io/en/stable/installing/"
      ;;
    esac
    pause 'Press [Enter] to continue...'
  fi
}

installdepsforneovim(){
  clear
  echo "Installing neovim dependencies..."
  echo "Would you install neovim dependencies  ? : 'Y' "
  echo "This will install cmake libtool-bin lua5.3 gettext libgettextpo-dev argparse"
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    case "${ARCH}" in
      "Ubuntu")
        sudo apt-get update
        sudo apt-get upgrade -y
        sudo apt install cmake libtool-bin gettext lua5.3 libgettextpo-dev gettext -y
        which pip3 > /dev/null && pip3 install argparse || installpip
     ;;
     "Darwin")
        sudo apt install cmake libtool-bin gettext lua libgettextpo-dev -y
        which pip3 > /dev/null && pip3 install argparse || installpip
        cd /tmp
        wget -q http://www.lua.org/ftp/lua-5.3.5.tar.gz
        tar xvfz lua-5.3.5.tar.gz
        cd lua-5.3.5
        sudo make macos install INSTALL_TOP=/usr/local/lua/5_3_5 MYLIBS="-lncurses"
        cd ..
        sudo rm -rf lua-5.3.5 lua-5.3.5.tar.gz
        cd
     ;;
     "Archlinux")
        sudo pacman -S base-devel cmake unzip ninja tree-sitter lua gettext -y
        which pip3 > /dev/null && pip3 install argparse || installpip
        cd /tmp
        wget -q http://www.lua.org/ftp/lua-5.3.5.tar.gz
        tar xvfz lua-5.3.5.tar.gz
        cd lua-5.3.5
        sudo make linux install INSTALL_TOP=/usr/local/lua/5_3_5 MYLIBS="-lncurses"
        cd ..
        sudo rm -rf lua-5.3.5 lua-5.3.5.tar.gz
        cd     
     ;;
     *)
        echo "This script don't know your distro yet"
        echo "Please install neovim dependencies manually"
        echo "https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites"
     ;;
   esac
   pause 'Press [Enter] to continue...'
 fi
}

installneovim(){
  if [[ "$install" ==  2 ]]; then
    echo
    echo "install failed twice please relaunch the script or install manually"
    echo
    echo "
    git clone https://github.com/neovim/neovim
    cd neovim
    sudo make CMAKE_BUILD_TYPE=Release install
    cd ..
    "
    echo
    echo "https://github.com/neovim/neovim/wiki/Installing-Neovim"
    echo
    pause 'Press [Enter] to continue...'
    exit 0
  fi
  ((install++))
  clear
  [[ "$install" ==  0 ]] && echo "Installing neovim 0.5 ..."
  [[ "$install" ==  0 ]] && echo "Would you install neovim 0.5 ? : 'Y' "
  [[ "$install" ==  0 ]] && read choice || choice="y"
  if [[ "$choice" ==  [yY] ]]; then
    case "${ARCH}" in
     "Ubuntu")
       which cmake > /dev/null && echo "cmake installed, moving on..." || installdepsforneovim
       which git > /dev/null && git clone https://github.com/neovim/neovim || installgit
       if [ -d "neovim" ]; then
         cd neovim
       else 
         git clone https://github.com/neovim/neovim
         cd neovim
       fi
       sudo make CMAKE_BUILD_TYPE=Release install
       cd ..
       which nvim >/dev/null && echo "neovim install done" || installneovim
       sudo rm -rf neovim
     ;;
     "Darwin")
       which cmake > /dev/null && echo "cmake installed, moving on..." || installdepsforneovim
       which git > /dev/null && git clone https://github.com/neovim/neovim || installgit
       if [ -d "neovim" ]; then
         cd neovim
       else 
         git clone https://github.com/neovim/neovim
         cd neovim
       fi
       sudo make CMAKE_BUILD_TYPE=Release install
       cd ..
       which nvim >/dev/null && echo "neovim install done" || installneovim
       sudo rm -rf neovim
     ;;
     "Archlinux")
       which cmake > /dev/null && echo "cmake installed, moving on..." || installdepsforneovim
       which yay >/dev/null && yay -Sa neovim-nightly-bin || sudo pacman -S yay && yay -Sa neovim-nightly-bin
       which nvim >/dev/null && echo "neovim install done" || installneovim
     ;;
     *)
       echo "This script don't know your distro yet"
       echo "Please install neovim 0.5 manually"
       echo "https://github.com/neovim/neovim/wiki/Installing-Neovim"
     ;;
    esac
    pause 'Press [Enter] to continue...'
  fi
}

installgit(){
  clear
  echo "Installing git..."
  echo "Would you install Git ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    case "${ARCH}" in
      "Ubuntu")
        sudo apt install git -y
      ;;
      "Darwin")
        brew install git
      ;;
      "Archlinux")
        sudo pacman -S git     
      ;;
      "Windows")
        echo
        echo "for install git in command line run copy and past the following line in cmd"
        echo "or you can download it from the site : https://git-scm.com/download/win"
        echo
        echo "this will install git from chocolatey :"
        echo
        set dir=%cd% && "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command Start-Process '%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe' -ArgumentList '-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString(''https://chocolatey.org/install.ps1''));choco upgrade -y git --params "/GitAndUnixToolsOnPath /NoAutoCrlf";  Read-Host ''Type ENTER to exit'' ' -Verb RunAs
      ;;
      *)
        echo "This script don't know your distro yet"
        echo "Please install neovim dependencies manually"
        echo "https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites"
      ;;
    esac
    pause 'Press [Enter] to continue...'
  fi 
}

cloneconfig() {
  clear
  echo "Cloning NVCode configuration"
  echo " which version ?
  $(ColorGreen '1)') Branch master
  $(ColorGreen '2)') Branch stable-snapshot-Native-LSP-1
  $(ColorGreen '3)') Branch stable-snapshot-CoC
  $(ColorGreen 'other)') Exit
  "
 local option
	  read -p "$(ColorBlue 'Choose option:') " option
    case $option in
      1)
        cd ~/.config
        [ -d "nvcode" ] && asktodelnvcode
        echo "Cloning NVCode configuration"
        git --version > /dev/null && git clone $URL ~/.config/nvcode || installgit
        cd
        [ -a ".local/share/nvim/site/pack/packer/start/packer.nvim" ] && echo 'packer already installed' || git clone https://github.com/wbthomason/packer.nvim .local/share/nvim/site/pack/packer/start/packer.nvim
        [ -f ".bashrc" ] && echo 'export PATH=$HOME/.config/nvcode/utils/bin:$PATH' >> ~/.bashrc
        [ -f ".bashrc" ] && source ~/.bashrc
        [ -f ".zshrc" ] &&  echo 'export PATH=$HOME/.config/nvcode/utils/bin:$PATH' >> ~/.zshrc
        [ -f ".zshrc" ] && source ~/.zshrc
        cd $HOME/.config/nvcode
        mv init.lua init.lua.tmp # backup init.Lua
        mv lua/plugins.lua utils/ # moving plugins.lua from lua folder to utils folder
        mkdir utils/tmp # create tmp folder
        mv lua/* utils/tmp/ # moving all lua file from lua folder to tmp folder
        mv utils/plugins.lua lua/  # plugins.lua to lua folder
        echo "vim.cmd('set rtp+=~/.config/nvcode')" > init.lua
        echo "require('plugins')" >> init.lua
        nvim -es -u init.lua -c :PackerInstall > /dev/null
	    nvim -es -u init.lua -c :PackerSync > /dev/null
	    echo
        mv utils/tmp/* lua/ # moving all lua file from tmp folder to lua folder
        rm init.lua
        mv init.lua.tmp init.lua
        sed -i "s/-- vim/vim/" init.lua
        sed -i "s/nvim\/vimscript\/nv-whichkey/nvcode\/vimscript\/nv-whichkey/" init.lua
        sed -i "s/nvim\/vimscript\/functions/nvcode\/vimscript\/functions/" init.lua
        nvim -es -u init.lua -c :PackerInstall > /dev/null
        echo "Nvcode install done"
        echo "Please run 'nv' and do :PackerInstall command"
        pause 'Press [Enter] to continue...'
        exec bash
      ;;
      2)
        cd ~/.config
        [ -d "nvim" ] && asktodelnvcode
        git --version > /dev/null && git clone $URL ~/.config/nvim || installgit
        cd nvim
        git checkout stable-snapshot-Native-LSP-1
        git pull
        clear
        echo "git nvim stable-lsp done"
        echo "Now you can run 'nvim' "
        cd
      ;;
      3)
        cd ~/.config
        [ -d "nvim" ] && asktodelnvcode
        git --version > /dev/null && git clone $URL ~/.config/nvim || installgit
        cd nvim
        git checkout stable-snapshot-CoC
        git pull
        cd
        nvim -es
        echo "git nvim stable-coc done"
        echo "Now you can run 'nvim' "
      ;;
      *) 
        echo "Cloning abort"
      ;;
    esac
    pause 'Press [Enter] to continue...'
    exec bash
}

installextrapackages(){
  clear
  echo "Extra packages for Nvcode..."
  echo "Would you install Extra packages ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    case "${ARCH}" in
      "Ubuntu")
        aptextrapackages
        npmextrapackages
        pipextrapackages
        luaextrapackages
        goextrapackages
      ;;
      "Darwin")
        brew install ripgrep fzf ranger
        npmextrapackages
        pipextrapackages
      ;;
      "Archlinux")
        sudo pacman -S ripgrep fzf ranger neovim-remote
        npmextrapackages
        pipextrapackages
        luaextrapackages
        goextrapackages
      ;;
      "Windows")
        npmextrapackages
        pipextrapackages
      ;;
      *)
        echo "This script don't know your distro yet"
        echo "Please install extra packages for Nvcode. manually"
        echo "https://github.com/ChristianChiarulli/nvcode/blob/master/README.md"
      ;;
    esac
    pause 'Press [Enter] to continue...'
  fi 
}

aptextrapackages() {
  clear
  echo "Extra apt packages ..."
  echo "Would you install apt packages ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    local list=("pandoc" "ripgrep" "fzf" "ranger" "libjpeg8-dev" "zlib1g-dev" "python-dev" "python3-dev" "libxtst-dev" "ninja-build" "xsel" "ruby")
    listloop
    echo "apt packages installation"
    sudo add-apt-repository ppa:lazygit-team/release
    sudo apt-get update
    for i in ${!list[@]}; do
      [[ "${choices[i]}" ]] && { sudo apt install -y "${list[i]}"; }
    done
    echo "Extra packages install done"
    pause 'Press [Enter] to continue...'
  fi
}

npmextrapackages() {
  clear
  echo "Extra npm packages ..."
  echo "Would you install npm packages ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    echo "npm packages installation"
    local list=("vscode-html-languageserver-bin" "typescript" "typescript-language-server" "bash-language-server" "vscode-css-languageserver-bin" "dockerfile-language-server-nodejs" "vim-language-server" "yaml-language-server" "graphql-language-service-cli" "vscode-json-languageserver")
    listloop
    echo "npm packages installation"
    for i in ${!list[@]}; do
      [[ "${choices[i]}" ]] && { sudo npm i -g "${list[i]}"; }
    done
    echo "Extra packages install done"
    pause 'Press [Enter] to continue...'
  fi
}

pipextrapackages() {
  clear
  echo "Extra pip packages ..."
  echo "Would you install pip packages ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    echo "pip3 packages installation"
    local list=("ueberzug" "neovim-remote" "fd" "flake8" "yapf")
    listloop
    echo "pip3 packages installation"
    for i in ${!list[@]}; do
      [[ "${choices[i]}" ]] && { sudo pip3 install "${list[i]}"; }
    done
    echo "Extra packages install done"
    pause 'Press [Enter] to continue...'
  fi
}

luaextrapackages() {
  clear
  echo "Extra luarocks packages ..."
  echo "Would you install luarocks packages ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    cd $HOME/.config
    [ -d "nvim" ] && cd nvim || mkdir nvim && cd nvim
    mkdir .language-servers
    cd .language-servers
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
  if [[ "$ARCH" ==  "Archlinux" ]]; then
    sudo pacman -S luarocks
  else
    cd /tmp
    sudo apt install build-essential libreadline-dev
    curl -R -O http://www.lua.org/ftp/lua-5.3.5.tar.gz
    tar -zxf lua-5.3.5.tar.gz
    cd lua-5.3.5
    make linux test
    sudo make install
    wget https://luarocks.org/releases/luarocks-3.3.1.tar.gz
    tar zxpf luarocks-3.3.1.tar.gz
    cd luarocks-3.3.1
    ./configure --with-lua-include=/usr/local/include
    sudo make install
    cd
  fi
    sudo luarocks install --server=https://luarocks.org/dev luaformatter
    pause 'Press [Enter] to continue...'
  fi
}

goextrapackages() {
clear
  echo "go installation"
  wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
  [ -f ".bashrc" ] && echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
  [ -f ".zshrc" ] && echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
  [ -f ".bashrc" ] && echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc && source ~/.bashrc
  [ -f ".zshrc" ] &&  echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.zshrc && source ~/.zshrc
  source ~/.profile
  echo "efm-langserver"
  which go > /dev/null && echo "go is installed" \
  &&  cd /tmp/ \
  && git clone https://github.com/mattn/efm-langserver.git \
  && make \
  && sudo mv efm-langserver /usr/bin/ \
  || echo "go not found" \
  && cd /tmp \
  && wget https://github.com/mattn/efm-langserver/releases/download/v0.0.26/efm-langserver_v0.0.26_linux_amd64.tar.gz \
  && tar xzf efm-langserver_*.tar.gz \
  && cd efm-langserver_*/ \
  && sudo mv efm-langserver /usr/bin/
  cd
  pause 'Press [Enter] to continue...'
}


installnerdfont(){
  clear
  echo
  echo "Nerd-fonts installation"
  echo
  echo "This will install all the fonts"
  echo
  echo "If you want to install specifique font :"
  echo "https://github.com/ryanoasis/nerd-fonts#font-installation"
  echo
  echo "Would you clone all the Nerd-fonts repo and install  ? : 'Y' "
  read choice
  if [[ "$choice" ==  [yY] ]]; then
    git --version > /dev/null && git clone https://github.com/ryanoasis/nerd-fonts.git || installgit
    if [ -d "nerd-fonts" ]; then
         cd nerd-fonts
       else 
         git clone https://github.com/ryanoasis/nerd-fonts.git
         cd nerd-fonts
    fi
    ./install.sh
    echo
    echo "Nerd-fonts installation done"
    echo "$HOME/Nerd-fonts folder was created"
    echo
    echo "If front doesn't work please run "
    echo "$HOME/nerd-fonts/./install.sh"
    echo
    pause 'Press [Enter] to continue...'
  fi
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
}

menuitems() {
    for i in ${!list[@]}; do
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${list[i]}"
    done
}

listloop(){
  while menuitems && read -rp "choose a package: " num && [[ "$num" ]]; do
    clear
    [[ "$num" != *[![:digit:]]* ]] && (( num > 0 && num <= ${#list[@]} )) || continue
    ((num--));
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="x"
  done
}

## ----------------------------------
# #8: Fonction launch by the script
## ----------------------------------
parse_options $@
