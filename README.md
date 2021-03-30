![NVCode Logo](./utils/media/nvcode_logo.png)

[![Support Server](https://img.shields.io/discord/591914197219016707.svg?color=7289da&label=AtMachine&logo=discord&style=flat-square)](https://discord.gg/Xb9B4Ny)
[![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)](https://github.com/ChristianChiarulli/nvcode/blob/master/LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/Naereen/StrapDown.js.svg)](https://github.com/ChristianChiarulli/nvcode/graphs/contributors)
[![Open Source? Yes!](https://badgen.net/badge/Open%20Source%20%3F/Yes%21/blue?icon=github)](https://github.com/Naereen/badges/)




![NVCode Demo](./utils/media/demo.png)

This project aims to help one transition away from VSCode, and into a superior text editing experience. (Just making this clear)

This is also a community project, if you would like to see support for a feature or language consider making a PR.

## Install In One Command!

Make sure you have the newest version of Neovim

``` bash
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/nvim/master/utils/installer/install.sh)
```

After installation run `nvim` and then `:PackerInstall`

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

I recommend you support Free/Libre versions if you plan to use VSCode:

- [VSCodium](https://vscodium.com/)

- Article to get you set up with VSCodium: [link](https://www.chrisatmachine.com/Neovim/22-vscodium-neovim/) 

After installing the [Neovim
extension](https://github.com/asvetliakov/vscode-neovim) in VSCode

I recommend using this alongside the VSCode
[which-key](https://github.com/VSpaceCode/vscode-which-key) extension

You will also need `settings.json` and `keybindings.json` which can be
found in utils/vscode\_config

Point the nvim path to your `nvim` binary

Point your `init.vim` path to:

``` vim
$HOME/.config/nvim/vimscript/nv-vscode/init.vim
```

## Clipboard Support

- On Mac `pbcopy` should be built-in

- Ubuntu

    ```bash
    sudo apt install xsel
    ```

- Arch

    ```bash
    sudo pacman -S xsel
    ```

- WSL2

    Make sure ~/bin is in your path in this case.
    
    ```bash
    curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
    unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
    chmod +x /tmp/win32yank.exe
    mv /tmp/win32yank.exe ~/bin
    ```

## LSP

To install a supported language server:

``` bash
  :LspInstall <your_language_server>
```

Most common languages should be supported out of the box, if yours is not I would welcome a PR

For a more in depth LSP support:
[link](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md)

## Useful Programs

``` bash
ranger
ueberzug
fd
ripgrep
jq
fzf
lazygit
lazydocker
ncdu
pynvim
neovim-remote
```

## EFM server

In order for linters and formatters to work you will need to install
`efm-langserver`

```vim
:LspInstall efm
```

## Formatters and Linters

**Python**

``` bash
pip3 install --user flake8
pip3 install --user yapf
```

**Lua**

``` bash
luarocks install --server=https://luarocks.org/dev luaformatter
```

**Yaml, Json, Javascript, HTML, CSS**

``` bash
npm install -g prettier
```

**Markdown**

``` bash
pandoc
```

## Vim Gists

To use vim-gists you will need to configure the following:

``` bash
git config --global github.user <username>
```

## Snippets

If you are looking for snippets checkout this github topic: [Snippet
Topic](https://github.com/topics/vscode-snippets)

## De-bugging

To set up your particular debugger, look here:
[link](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation)

## TODO

**HIGH PRIORITY**

Move user config into `config.lua` ts-comment string for react

From here I will update for bug fixes and implement low priority
features when I have time

**LOW PRIORITY**

- list all binaries needed for formatters and linters
- add badges to readme
- Implement what I can from this java config:
  [link](https://github.com/mfussenegger/nvim-jdtls/wiki/Sample-Configurations)
  - better ui for code actions - formatting
  - setup junit tests for java
- look into emmet-ls
- toggle virtual text diagnostics
- configure neogit
- vim ult test
- what is `fzy`
- https://github.com/pwntester/octo.nvim
- configure surround
- maybe incorporate ultisnips
- switch back to `nvim-autopairs` when/if it doesn't break snippets 
- Implement this for typescript https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils
- look into tabnine


**PLUGIN BUGS**

REACT COMMENTING IS A NIGHTMARE (the filetype is just not recognized idk why)
