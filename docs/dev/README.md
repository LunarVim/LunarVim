# Learning Lua

To get started, [this guide](https://github.com/nanotee/nvim-lua-guide) covers many points that will get you going with Lua and how Neovim works.

## Official Documentation

The [reference manual](https://www.lua.org/manual/5.4/) is the official definition of the Lua language.

If you don't know about it, [DevDocs](https://devdocs.io/lua~5.4/) combines multiple API documentations in a fast, organized, and searchable interface.

## Neovim Documentation

Neovim provides a [standard library](https://neovim.io/doc/user/lua.html) which you should know about.

It provides many functions that you wish were implemented in Lua's stdlib, for instance `strings.split`.

It also comes with a [LSP framework](https://neovim.io/doc/user/lsp.html) and [much more](https://neovim.io/doc/user/).

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

## Style Guide

LuaRock [style guide](https://github.com/luarocks/lua-style-guide) is a complete work that deserves a look if you want learn how to write consistent and robust code.

It is based on many pre-existing guides, provides rationals for all their decisions, and worked successfully in a long-running project.

## Code Quality

To ensure code quality and a consistent style, our [CI](https://github.com/Lunarvim/LunarVim/actions) uses the following tools:

- Lua:
  - [Stylua](https://github.com/JohnnyMorganz/StyLua). An opinionated Lua code formatter.
  - [Luacheck](https://github.com/mpeterv/luacheck). A tool for linting and static analysis of Lua code. 
- Shell
  - [Shfmt](https://github.com/mvdan/sh). A shell parser, formatter, and interpreter with bash support.
  - [Shellcheck](https://github.com/koalaman/shellcheck). A static analysis tool for shell scripts.

## Manual install 

Complete the preparatory steps under Install above up to the running of the install script.

Install `xclip`, `python3`, `ripgrep`, `fzf`, `pip` and `git` with the package manager for your distribution:

```bash
# Ubuntu
sudo apt install git xclip python3-pip ripgrep fzf libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev python3-pip

# Arch
sudo pacman -S git xclip python python-pip ripgrep fzf 

# Fedora
sudo dnf groupinstall "X Software Development"
sudo dnf install -y git xclip python3-devel pip ripgrep fzf pip3 install wheel 

# Gentoo
sudo emerge -avn sys-apps/ripgrep app-shells/fzf app-misc/dev-python/neovim-remote virtual/jpeg sys-libs/zlib
sudo emerge -avn dev-python/pip
# Optional.   Enable npm USE flag with flaggie
sudo flaggie net-libs/nodejs +npm
sudo emerge -avnN net-libs/nodejs

# Mac
brew install git lua node yarn ripgrep fzf 
sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
rm get-pip.py
```

Install `tree-sitter-cli`:

```bash
npm install -g neovim tree-sitter-cli
```

Install `neovim`, `neovim-remote` and `pynvim` with pip3:

```bash
pip3 install neovim neovim-remote pynvim --user
```

Clone plugins: 

```bash
mkdir -p ~/.local/share/lunarvim/site/pack/packer/start/
cd ~/.local/share/lunarvim/site/pack/packer/start/
git clone https://github.com/wbthomason/packer.nvim.git
```

Clone LunarVim:

```bash
#Rolling Branch
git clone --branch rolling https://github.com/ChristianChiarulli/lunarvim.git 

#Stable Branch
git clone --branch master https://github.com/ChristianChiarulli/lunarvim.git 
```

Create your configuration file:

```bash
mkdir -p ~/.config/lvim
cp ~/.local/share/lunarvim/lvim/utils/installer/config.example.lua ~/.config/lvim/config.lua
```




