# Install

If you already have an `nvim` directory under `~/.config`, don't worry, LunarVim will not overwrite it. Your LunarVim config will be located in `~/.config/lvim`.

If you want to update an existing LunarVim install, follow the procedures [here](./03-updating.md). If you run the following install script with an existing `~/.local/share/lunarvim` directory, the script will exit and ask you to move it (e.g. `mv /old /new`).

## Prepare

### Install the `neovim` (>= v0.5.0) and `git` packages

If you want to compile `neovim` from source and install, see [here](./dev/#compiling-neovim-from-source).

### Install `pip`

| OS     | Command                                                      |
| ------ | ------------------------------------------------------------ |
| Mac    | sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py |
|        | python3 get-pip.py                                           |
|        | rm get-pip.py                                                |
| Ubuntu | sudo apt install python3-pip \>/dev/null                     |
| Arch   | sudo pacman -S python-pip                                    |
| Fedora | sudo dnf install -y pip \>/dev/null                          |
| Gentoo | sudo emerge -avn dev-python/pip                              |
| Termux | apt install python                                           |

### Install [fnm](https://github.com/Schniz/fnm) or another [node version manager](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally)

LunarVim requires a globally-installed `npm` package called `tree-sitter-cli`. Installing global `npm` packages on Linux is not always straightforward, so we recommend using a node version manager (hereafter, nvm) to handle your `nodejs` and `npm` versions. You can use an nvm in conjunction with your distribution's official `nodejs` and `npm` packages, but you may find it simpler to just use an nvm by itself and not install `nodejs` and `npm` through your package manager at all. We recommend an [nvm called fnm](https://www.youtube.com/watch?v=ClrXIi8qTtI). Users who do not use an nvm to install global `npm` packages may get an error when the LunarVim install script runs.

### Install `nodejs` and `npm`

Your nvm will have a way to install versions of `nodejs` and `npm`. With `fnm` the command to install the LTS version of `nodejs` (which will include `npm`) is `fnm install --lts`. After installing `nodejs` you should not have any difficulty globally-installing `npm` packages.

### Prepare PATH for `neovim-remote`

LunarVim also requires a python package called `neovim-remote`. Upon installation, it will warn that it needs to be added to your PATH environment variable. Add this line to your `.bashrc` or other shell config file to prevent the warning:

```bash
export PATH=/home/$USER/.local/bin:$PATH
```

Close and reopen your shell window or run `source ~/.bashrc` (or other shell config file) to effectuate the changes.

With the manual prep out of the way, we are ready to install LunarVim!

## Run one of the following commands

### Stable (master branch)

No alarms and no surprises:

```bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

### Unstable (rolling branch)

All the new features with all the new bugs:

```bash
LVBRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
```

That's it! Please continue on to [Quick Start](./02-after-install.md)!

## Troubleshooting installation problems

If you encounter problems with the installation check the following:

1. Make sure you have at least version 0.5.0 of `neovim`. There were some breaking changes in the development of 0.5.0 so upgrade to the newest available version to rule out incompatibilities.

2. Make sure `neovim` was compiled with `luajit`:

```bash
# The output of version information should include a line for: LuaJIT
nvim -v
```

3. Make sure all the dependencies listed in [Manual Install](./dev/#manual-install) are actually installed on your system. Your distribution's package manager will have a way to inspect what you have installed.

4. Make sure you have followed the procedures in [Quick Start](./02-after-install.md) to install and update your plugins.

5. If you're upgrading your install, sometimes an old `packer` compiled file can cause errors at runtime. Remove the plugin folder with `rm -rf ~/.config/lvim/plugin` and run `:PackerSync`.

6. If you got an EACCES `npm` error you need to be sure you can install global `npm` packages without `sudo` as described [here](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally).

## Uninstall

You can remove LunarVim entirely (while preserving `neovim`) by running the following commands:

```bash
rm -rf ~/.local/share/lunarvim

sudo rm /usr/local/bin/lvim

rm -rf ~/.local/share/applications/lvim.desktop
```

## Manual Install

Install `xclip`, `python3`, `ripgrep` and `fzf` with the package manager for your distribution:

```bash
# Ubuntu
sudo apt install xclip ripgrep fzf libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev

# Arch
sudo pacman -S xclip python ripgrep fzf

# Fedora
sudo dnf groupinstall "X Software Development"
sudo dnf install -y xclip python3-devel ripgrep fzf
pip3 install wheel

# Gentoo
sudo emerge -avn sys-apps/ripgrep app-shells/fzf app-misc/dev-python/neovim-remote virtual/jpeg sys-libs/zlib
# Optional.   Enable npm USE flag with flaggie
sudo flaggie net-libs/nodejs +npm
sudo emerge -avnN net-libs/nodejs

# Mac
brew install lua ripgrep fzf

# Termux
sudo apt install ripgrep fzf xclip python
```

Install the `neovim` and `tree-sitter-cli` packages globally with `npm`:

```bash
npm install -g neovim tree-sitter-cli
```

Install the `neovim`, `neovim-remote` and `pynvim` packages with `pip3`:

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
git clone --branch rolling https://github.com/LunarVim/lunarvim.git ~/.local/share/lunarvim/lvim

#Stable Branch
git clone --branch master https://github.com/LunarVim/lunarvim.git ~/.local/share/lunarvim/lvim
```

Create your configuration file:

```bash
mkdir -p ~/.config/lvim
cp ~/.local/share/lunarvim/lvim/utils/installer/config.example.lua ~/.config/lvim/config.lua
```

Install plugins

```bash
#launch LunarVim
lvim

# Type this command
:PackerSync
```
