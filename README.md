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

## TODO
- snippet support
- add lots of lsp
- configure neogit
- configure git blame
- move language servers not installed with npm to neovim local share location
- add vscode support
- react commenting
- add lisence
- add icons to startify
- update whichkey bindings
- more handsome/modern galaxyline
- potentially custom colorscheme
- get logo
- look into autoinstall lsp
- prefer single line comments kommentary
