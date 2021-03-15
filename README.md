# NVCode

If you are looking for my old configs checkout the two snapshot branches on this repo, there is one for CoC and one for Native LSP

## Install in one command

```
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/nvcode/master/utils/installer/install-nv-code.sh)
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

## TODO

**HIGH PRIORITY**
- snippet support
- update whichkey bindings
- add lots of lsp
- react commenting
- toggle virtual text diagnostics

**LOW PRIORITY**
- improve VSCode support
- move language servers not installed with npm to neovim local share location
- more handsome/modern galaxyline
- better autoimport
- potentially custom colorscheme
- look into autoinstall lsp
- get logo
- configure neogit
