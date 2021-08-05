# Install

If you already have an `nvim` directory under `~/.config` don't worry, LunarVim will not overwrite it. Your LunarVim config will be located in `~/.config/lvim`.


To install LunarVim:

Install the `neovim` (>= v0.5.0) and `git` packages. If you want to compile `neovim` from source and install, see [here](#compiling-neovim-from-source).

LunarVim requires a globally-installed `npm` package called `tree-sitter-cli`. Installing global `npm` packages on Linux is not always straightforward, so we recommend using a node version manager (hereafter, nvm) to handle your `nodejs` and `npm` versions. You can use an nvm in conjunction with your distribution's official `nodejs` and `npm` packages, but you may find it simpler to just use an nvm by itself and not install `nodejs` and `npm` through your package manager at all. We recommend an [nvm called fnm](https://www.youtube.com/watch?v=ClrXIi8qTtI). Users who do not use an nvm to install global `npm` packages may get an error when the LunarVim install script runs.

Install [`fnm`](https://github.com/Schniz/fnm) or another [node version manager](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally). 

Your nvm will have a way to install versions of `nodejs` and `npm`. With `fnm` the command to install the LTS version of `nodejs` (which will include `npm`) is `fnm install --lts`. After installing `nodejs` you should be able to install global `npm` packages with no difficulty.

LunarVim also requires a python package called `neovim-remote`. Upon installation, it will warn that it needs to be added to your PATH environment variable. Add this line to your `.bashrc` or other shell config file to prevent the warning:

```bash
export PATH=/home/$USER/.local/bin:$PATH
``` 

Close and reopen your shell window or run `source ~/.bashrc` (or other shell config file) to effectuate the changes.

If you want to update an existing LunarVim install, follow the procedures [here-TBD](). If you run the following install script with an existing `~/.local/share/lunarvim` directory, the script will exit and ask you to move it (e.g. `mv /old /new`).

With the manual prep out of the way, we are ready to install LunarVim!

Run one of the following commands:

## Stable (master branch)

No alarms and no surprises:

``` bash
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/master/utils/installer/install.sh)
```

## Unstable (rolling branch)

All the new features with all the new bugs:

```bash
LVBRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/rolling/utils/installer/install.sh)
```

That's it! Please continue on to Quick Start!


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
npm i -g tree-sitter-cli
```

Install `neovim-remote` and `pynvim` with pip3:

```bash
pip3 install neovim-remote pynvim --user
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
git clone -branch rolling https://github.com/ChristianChiarulli/lunarvim.git 

#Stable Branch
git clone -branch master https://github.com/ChristianChiarulli/lunarvim.git 
```

Create your configuration file:

```
mkdir -p ~/.config/lvim
cp ~/.local/share/lunarvim/lvim/utils/installer/config.example.lua ~/.config/lvim/config.lua
```

That's it! Please continue on to Quick Start!


## Troubleshooting installation problems
If you encounter problems with the installation check the following: 

1. Make sure you have at least version 0.5.0 of `neovim`. There were some breaking changes in the development of 0.5.0 so upgrade to the newest available version to rule out incompatibilities.
 
2. Make sure `neovim` was compiled with `luajit`: 
```bash
# The output of version information should include a line for: LuaJIT 
nvim -v
```

3. Make sure all the dependencies listed in [Manual Install](#manual-install) are actually installed on your system. Your distribution's package manager will have a way to query what you have installed.

4. Make sure you have followed the procedures in Quick Start to install and update your plugins.

5. If you're upgrading your install, sometimes an old `packer` compiled file can cause errors at runtime.  Remove the plugin folder with `rm -rf ~/.config/lvim/plugin` and run `:PackerSync`.


## Uninstall

You can remove LunarVim entirely (while preserving `neovim`) by running the following commands: 

```bash
rm -rf ~/.local/share/lunarvim

sudo rm /usr/local/bin/lvim

rm -rf ~/.local/share/applications/lvim.desktop
```

