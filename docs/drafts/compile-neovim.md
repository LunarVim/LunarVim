## Compiling Neovim from Source

First, get the dependencies. For distributions other than Ubuntu or Arch, go [here](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites).

```bash
#Ubuntu
sudo apt-get install gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip build-essential
#Arch
sudo pacman -S base-devel cmake unzip ninja tree-sitter
```

Download and compile Neovim:

```bash
cd $(mktemp -d)
git clone https://github.com/neovim/neovim
cd neovim
sudo make CMAKE_BUILD_TYPE=Release install
cd ..
sudo rm -r neovim
```

or if you are on Arch you can get the development version from the AUR:

```bash
yay -S neovim-git
```

If you are on Gentoo you have to emerge the 9999 neovim version with luajit as the lua single target.
