# NVCode

## Install in one command

**WARNING** Still very experimental will not woek without some configuation

```bash
bash <(curl -s https://raw.githubusercontent.com/mjcc30/nvcode/master/utils/installer/install-nv-code.sh)
```

After running you will have access to the `nv` command, this WILL NOT overwite your nvim config. So you can have both installed at the same time

## Get the latest version of Neovim 

```bash
cd ~
sudo rm -r neovim
git clone https://github.com/neovim/neovim
cd neovim
sudo make CMAKE_BUILD_TYPE=Release install
cd ~
sudo rm -r neovim
```

## VSCode support

After installing the Neovim extension in VSCode

Point the nvim path to your `nvim` binary

Point your `init.vim` path to:

```vim
$HOME/.config/nvim/lua/nv-vscode/init.vim
```

or if you are using this config alongside your own:

```vim
$HOME/.config/nvim/lua/nv-vscode/init.vim
```
