# NVCode

![NVCode pic](./utils/images/nvim.png)

## Install in one command

The following will install this config if you have an existing config it will move it to `~/.config/nvim.old`

This script only supports Mac, Ubuntu and Arch

```
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/nvim/master/utils/install.sh)
```

## Install Neovim

- Mac

  ```
  brew install --HEAD neovim # Nightly version

  brew upgrade neovim --fetch-HEAD # Sometimes you need to update
  ```

- Ubuntu

  ```
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o /tmp/nvim.appimage

  sudo mv /tmp/nvim.appimage /usr/local/bin/nvim

  chmod +x /usr/local/bin/nvim
  ```

- Arch

  ```
  yay -S neovim-git # Latest
  ```

## Clone this repo into your config

```
git clone https://github.com/ChristianChiarulli/nvim.git ~/.config/nvim
```

## Install python & node support

```
pip install pynvim
```

```
npm i -g neovim
```

## Install Neovim remote

```
pip install neovim-remote
```

This will install `nvr` to `~/.local/bin` so you will need to add the following to your `bashrc` or `zshrc`

```
export PATH=$HOME/.local/bin:$PATH
```

## Install clipboard support

- On Mac pbcopy should be builtin

- Ubuntu

  ```
  sudo apt install xsel
  ```

- Arch

  ```
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

Explanations and installation instruction can be found on my blog

## Language Servers

Since CoC doesn't support all languages in there extensions
I recommend installing some language servers from scratch
and adding them to your `coc-settings.json` file

Example:

- bash

  `npm i -g bash-language-server`

  ```
  "languageserver": {
  "bash": {
    "command": "bash-language-server",
    "args": ["start"],
    "filetypes": ["sh"],
    "ignoredRootPaths": ["~"]
    }
  }
  ```

## For FAR to work

```
:UpdateRemotePlugins
```

## TabNine

To use TabNine enter the following in a buffer:

```
TabNine::config
```

**NOTE** This extension can take up a ton of memory

## Vim Gists

To use **vim-gists** you will need to configure the following:

```
git config --global github.user <username>
```

## VSCodium & Neo Vim Extension

[VSCodium](https://github.com/VSCodium/vscodium) contains build files to generate free release binaries of Microsoft's VS Code.

You can install it on multiple platforms:

- Mac

  ```
  brew cask install vscodium
  ```

- Arch

  ```
  yay -s vscodium-bin
  ```

- Snap

  ```
  snap install codium
  ```

[The Neo Vim Extension](https://github.com/asvetliakov/vscode-neovim) is available in the VSCode marketplace

I recommend using this alongside the VSCode `which-key` extension

Along with some of my config files you can find in `utils/vscode_config`

## TODO

- Better Documentation

## CoC extensions to check out

- coc-fzf-preview
  - https://github.com/yuki-ycino/fzf-preview.vim/
- coc-floaterm

## 0.5

- native lsp
- treesitter

## LOW PRIORITY TODO

If anyone reading this has any suggestions about implementing any of the following I will accept a PR, but these are not priority.

- ale
- multiple cursors
- markdown table
- galaxyline automatically grab colors from colorscheme
- tpope/vim-dadbod
- neovide
- People asked about vimwiki I kinda hate it but maybe I'll add it
- vimspector this is included but I don't plan on using it much
  - can be used with jdb, pdb, gdb, etc...
- nvim-dap and nvim-dap-virtual-text (ALL DEBUGGING IN NEOVIM IS CONFUSING AND HARD TO GET WORKING OR I'M JUST DUMB)
- later manually link pylance
- resize with arrows in addition to meta
- how to support meta key on for macOS?
