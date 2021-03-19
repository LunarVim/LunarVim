# NVCode

If you are looking for my old configs checkout the two snapshot branches on this repo, there is one for CoC and one for Native LSP

## Install in one command

**WARNING** Still very experimental will not work without some configuation

You will need to run `nv` then `:PackerInstall` ignore the errors that are presented 

```bash
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

After installing the [Neovim extension](https://github.com/asvetliakov/vscode-neovim) in VSCode

I recommend using this alongside the VSCode which-key extension

Along with some of my config files you can find in utils/vscode_config

Point the nvim path to your `nvim` binary

Point your `init.lua` path to:

```vim
$HOME/.config/nvim/lua/nv-vscode/init.lua
```

or if you are using this config alongside your own:

```vim
$HOME/.config/nvim/lua/nv-vscode/init.lua
```

## efm server is slow on close

Install the latest with:

```
go get github.com/mattn/efm-langserver@HEAD
```

## Useful Programs

```
ranger
ueberzug
fd
ripgrep
jq
fzf
lazygit
lazydocker
ncdu
```

**Python**

```
pyright
flake8
yapf
```

**Lua**

```
ninja
lua-format
sumneko-lua
```

## Vim Gists

To use vim-gists you will need to configure the following:

```
git config --global github.user <username>
```

## TODO

**HIGH PRIORITY**
- list all binaries needed for functionality
- learn what opt is
- better install script, support both nvim and nvcode paths
- learn nvim-dap in depth
- snippet support
- for vsnip :h vim-vsnip, also figure out what integr does

**LOW PRIORITY**
- add utf8 line col and spaces (maybe blame)
- potentially switch to dashboard
- make java code actions prettier
- figure out how to customize java formatting
- setup junit tests for java
- neovim lightbulb config
- better autoimport
- keep and eye on indent guides plugin for thin lines
- look into autoinstall lsp
- get logo
- configure neogit
- toggle virtual text diagnostics
- move language servers not installed with npm to neovim local share location
