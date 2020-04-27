# Nvim Mach 2

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
git clone https://github.com/ChristianChiarulli/nvim.git ~/.config
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

Explainations and installation instrucion can be found on my blog
