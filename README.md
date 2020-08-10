# Nvim Mach 2

![Nvim Mach 2 pic](./utils/images/nvim.png)

## Install in one command

The following will install this config if you have an existing config it will move it to `~/.config/nvim.old`

This script only supports Mac, Ubuntu and Arch

```
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/nvim/master/utils/install.sh)
```

## Install Neovim

- On Mac

  ```
  brew install neovim
  ```

- Ubuntu

  ```
  sudo apt install neovim
  ```

- Arch

  ```
  sudo pacman -S neovim
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

- On mac pbcopy should be builtin

- On Ubuntu

  ```
  sudo apt install xsel
  ```

- On Arch Linux

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

To use tabnine enter the following in a buffer:

```
TabNine::config
```

## Vim Gists

To use **vim-gists** you will need to configure the following:

```
git config --global github.user <username>
```

## TODO

- Better Documentation

## CoC extensions to check out

- coc-fzf
- coc-stylelintplus
- coc-floaterm
- coc-actions
- coc-bookmark

## 0.5

- native lsp
- treesitter

## LOW PRIORITY TODO

If anyone reading this has any suggestions about implementing any of the following I will accept a PR, but these are not priority.

- ale
- multiple cursors
- markdown table
- spaceline (add colorscheme for mach2)
- tpope/vim-dadbod
- neovide
- People asked about vimwiki I kinda hate it but maybe I'll add it
- vimspector this is included but I don't plan on using it much
  - can be used with jdb, pdb, gdb, etc...
- later manually link pylance
- resize with arrows in addition to meta
- how to support meta key on for macOS?
