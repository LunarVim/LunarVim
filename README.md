# NVCode

![NVCode pic](./utils/images/nvim.png)

## Install in one command

The following will install this config if you have an existing config it will move it to `~/.config/nvim.old`

This script only supports Mac, Ubuntu and Arch

```bash
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/nvim/master/utils/install.sh)
```

## Install Neovim

To get the latest and greatest:

```bash
cd ~
sudo rm -r neovim
git clone https://github.com/neovim/neovim
cd neovim
sudo make CMAKE_BUILD_TYPE=Release install
cd ~
sudo rm -r neovim
```


## Clone this repo into your config

```bash
git clone https://github.com/ChristianChiarulli/nvim.git ~/.config/nvim
```

## Install python & node support

```bash
pip install pynvim
```

```bash
npm i -g neovim
```

## Install Neovim remote

```bash
pip install neovim-remote
```

This will install `nvr` to `~/.local/bin` so you will need to add the following to your `bashrc` or `zshrc`

```
export PATH=$HOME/.local/bin:$PATH
```

## Install clipboard support

- On Mac pbcopy should be builtin

- Ubuntu

  ```bash
  sudo apt install xsel
  ```

- Arch

  ```bash
  sudo pacman -S xsel
  ```

## (Optional) Install python & node support using virtual environments

Make sure to add these paths somewhere in your config

```
let g:python3_host_prog = expand("<path to python with pynvim installed>")
let g:python3_host_prog = expand("~/.miniconda/envs/neovim/bin/python3.8") " <- example

let g:node_host_prog = expand("<path to node with neovim installed>")
let g:node_host_prog = expand("~/.nvm/versions/node/v12.16.1/bin/neovim-node-host") " <- example
```

## List of programs you should install

- ranger
- ueberzug
- ripgrep
- silver_searcher
- fd
- universal-ctags
- lazy git
- lazy docker
- ninja (for lua lsp)

Explanations and installation instruction can be found on my blog

## Language Servers

Some example language servers, if you just install them they will work with this config

```bash
npm i -g pyright
npm i -g bash-language-server
npm install -g vscode-css-languageserver-bin
npm install -g dockerfile-language-server-nodejs
npm install -g graphql-language-service-cli
npm install -g vscode-html-languageserver-bin
npm install -g typescript typescript-language-server
npm install -g vscode-json-languageserver
npm install -g vim-language-server
npm install -g yaml-language-server
```

Go [here](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md)

How to install the lua language server: [link](https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone))

## For FAR to work

```vim
:UpdateRemotePlugins
```

To replace in file make sure to specify `%:p`
To replace across project specify `**/*.<your_extension>`

## Vim Gists

To use **vim-gists** you will need to configure the following:

```bash
git config --global github.user <username>
```

## VSCodium & Neo Vim Extension

[VSCodium](https://github.com/VSCodium/vscodium) contains build files to generate free release binaries of Microsoft's VS Code.

You can install it on multiple platforms:

- Mac

  ```bash
  brew cask install vscodium
  ```

- Arch

  ```bash
  yay -s vscodium-bin
  ```

- Snap

  ```bash
  snap install codium
  ```

[The Neo Vim Extension](https://github.com/asvetliakov/vscode-neovim) is available in the VSCode marketplace

I recommend using this alongside the VSCode `which-key` extension

Along with some of my config files you can find in `utils/vscode_config`

## TODO

- Better Documentation
  https://github.com/gennaro-tedesco/nvim-jqx

  https://github.com/mattn/efm-langserver

  https://github.com/nvim-telescope/telescope-media-files.nvim

  https://github.com/b3nj5m1n/kommentary

  https://github.com/nvim-lua/completion-nvim

  https://github.com/nvim-telescope/telescope-frecency.nvim

## 0.5

- native lsp (in progress)
- treesitter (in progress)

## LOW PRIORITY TODO

If anyone reading this has any suggestions about implementing any of the following I will accept a PR, but these are not priority.

- multiple cursors
- galaxyline automatically grab colors from colorscheme
- tpope/vim-dadbod
- neovide
- People asked about vimwiki I kinda hate it but maybe I'll add it
- vimspector this is included but I don't plan on using it much
  - can be used with jdb, pdb, gdb, etc...
- nvim-dap and nvim-dap-virtual-text (ALL DEBUGGING IN NEOVIM IS CONFUSING AND HARD TO GET WORKING OR I'M JUST DUMB)
- potentially manually link pylance
- resize with arrows in addition to meta
- how to support meta key on for macOS?
