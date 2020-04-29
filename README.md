# Nvim Mach 2

## VSCode integration

We will be integrating with VSCode using [this](https://github.com/asvetliakov/vscode-neovim)

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
let g:node_host_prog = expand("~/.nvm/versions/node/v12.16.1/bin/node") " <- example 
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

Explainations and installation instrucion can be found on my blog

# TODO 
- Map which key stuff
- People asked about vimwiki I kinda hate it but maybe I'll add it
- try this out https://github.com/asvetliakov/vim-easymotion
- update startify
- float term lazy git
- spectre, or async task/run
- setup custom paths
- install script envsubst is your friend
