![NVCode Logo](./utils/media/nvcode_logo.png)


![NVCode Demo](./utils/media/demo.png)

If you are looking for my old configs checkout the two snapshot branches
on this repo, there is one for CoC and one for Native LSP

## Get the latest version of Neovim

``` bash
cd ~
sudo rm -r neovim
git clone https://github.com/neovim/neovim
cd neovim
sudo make CMAKE_BUILD_TYPE=Release install
cd ~
sudo rm -r neovim
```

## VSCode support

After installing the [Neovim
extension](https://github.com/asvetliakov/vscode-neovim) in VSCode

I recommend using this alongside the VSCode which-key extension

Along with some of my config files you can find in utils/vscode\_config

Point the nvim path to your `nvim` binary

Point your `init.lua` path to:

``` vim
$HOME/.config/nvim/lua/nv-vscode/init.lua
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

## LSP

Some example language servers, if you just install them they will work
with this config

``` bash
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
npm install markdownlint --save-dev
```

For a more in depth LSP support:
[link](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md)

## efm server is slow on close

Install the latest with:

``` bash
go get github.com/mattn/efm-langserver@HEAD
```

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

**Python**

``` bash
pyright
flake8
yapf
```

**Lua**

``` bash
ninja
lua-format
sumneko-lua
```

**Yaml, Json, Javascript, HTML, CSS**

``` bash
prettier
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

## TODO

**HIGH PRIORITY**

- learn nvim-dap in depth
- Implement what I can from this java config:
  [link](https://github.com/mfussenegger/nvim-jdtls/wiki/Sample-Configurations)
  - better ui for code actions - formatting
  - setup junit tests for java
- neovim light-bulb config
- better vscode support


**LOW PRIORITY**

- look into auto-install lsp
- json config file (luajson)
- better install script, support both nvim and nvcode paths
- get logo
- look into emmet-ls
- toggle virtual text diagnostics
- configure neogit
- list all binaries needed for functionality
- html snippets in react (maybe)
- configure kshenoy/vim-signature
- vim ult test
- what is `fzy`
- https://github.com/pwntester/octo.nvim
- configure surround

**PLUGIN BUGS**

- finding files from dashboard sometimes number not set
- spell not activated in readme Markdown
- better auto-import
- can't find global binary for markdown-lint
- keep and eye on indent guides plugin for thin lines
