# Install

To install LunarVim:

Remove the following folders, if any exist. If you already have a `nvim` directory under `~/.config`, move it with `mv nvim/ nvim-old/`.

`~/.cache/nvim`
`~/.config/nvim`                        
`~/.config/lvim` 
`~/.local/share/nvim/site/pack/packer` 
`~/.local/share/lunarvim`             

Install Neovim (>= v0.5.0). If you want to compile from source and install, see [here](#compiling-neovim-from-source).

Run the following appropriate command for your respective OS:

```bash
# Ubuntu
sudo apt install xclip python3-pip nodejs npm ripgrep fzf libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev python3-pip

# Arch
sudo pacman -S xclip python python-pip nodejs npm ripgrep fzf 

# Fedora
sudo dnf groupinstall "X Software Development"
sudo dnf install -y xclip python3-devel pip nodejs npm ripgrep fzf 
pip3 install wheel ueberzug

# Gentoo
sudo emerge -avn sys-apps/ripgrep app-shells/fzf app-misc/dev-python/neovim-remote virtual/jpeg sys-libs/zlib
sudo emerge -avn dev-python/pip
# Optional.   Enable npm USE flag with flaggie
sudo flaggie net-libs/nodejs +npm
sudo emerge -avnN net-libs/nodejs

# Mac
brew install lua node yarn ripgrep fzf 
sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
rm get-pip.py
```

Run one of the following commands:

## Stable (master branch)

``` bash
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/master/utils/installer/install.sh)
```

## Unstable (rolling branch)

All the new features with all the new bugs:

```bash
LVBRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/rolling/utils/installer/install.sh)
```





## Compiling Neovim from source

First, get the dependencies. For distributions other than Ubuntu or Arch, go [here](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites).

``` bash
#Ubuntu
sudo apt-get install gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip build-essential
#Arch
sudo pacman -S base-devel cmake unzip ninja tree-sitter
```

Download and compile Neovim:

``` bash
cd $(mktemp -d)
git clone https://github.com/neovim/neovim
cd neovim
sudo make CMAKE_BUILD_TYPE=Release install
cd ..
sudo rm -r neovim
```

or if you are on Arch you can get the development version from the AUR:

``` bash
yay -S neovim-git
```

If you are on Gentoo you have to emerge the 9999 neovim version with luajit as the lua single target.

## Manual install 

Install xclip, python3, ripgrep, fzf, npm, nodejs, pip, and with the package manager for your distribution.
Install tree-sitter.  To globally install packages without the need for sudo
follow [this guide](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally)

```bash
npm install -g tree-sitter-cli
```

Install ueberzug, neovim-remote, and pynvim with pip3

```bash
pip3 install ueberzug neovim neovim-remote pynvim --user
```

Clone plugins 

```bash
mkdir -p ~/.local/share/lunarvim/site/pack/packer/start/
cd ~/.local/share/lunarvim/site/pack/packer/start/
git clone https://github.com/wbthomason/packer.nvim.git
git clone https://github.com/tamago324/nlsp-settings.nvim.git
git clone https://github.com/jose-elias-alvarez/null-ls.nvim.git
```

Clone LunarVim
```bash
#Rolling Branch
git clone -branch rolling https://github.com/ChristianChiarulli/lunarvim.git 

#Stable Branch
git clone -branch master https://github.com/ChristianChiarulli/lunarvim.git 
```

Create your configuration file
```
mkdir -p ~/.config/lvim
cp ~/.local/share/lunarvim/lvim/utils/installer/lv-config.example.lua ~/.config/lvim/lv-config.lua
```


## Troubleshooting installation problems
If you encounter problems with the installation check the following: 
1. Make sure you have at least version 0.5 of neovim. There were some breaking changes in the development of 0.5 so upgrade to the newest available version to rule out incompatibilities.  
1. Make sure neovim was compiled with luajit. 
  ```bash
  # The output of version information should include a line for: LuaJIT 
  nvim -v
  ```
1. Make sure all the dependencies listed in [Manual Install](#manual-install) are actually installed on your system.
1. Make sure your plugins are installed and updated. Run `:PackerSync`
1. If you're upgrading your install, sometimes an old packer compiled file can cause errors at runtime.  Remove the folder.  `rm -rf ~/.config/lvim/plugin` and run `:PackerSync`

## Uninstall

You can remove LunarVim entirely by running the following commands: 

```bash
rm -rf ~/.local/share/lunarvim

sudo rm /usr/local/bin/lvim

rm -rf ~/.local/share/applications/lvim.desktop
```


