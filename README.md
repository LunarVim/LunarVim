```
```

# Table of contents
- [What's included?](#whats-included)
  - [Why do I want tree-sitter and LSP?](#why-do-i-want-tree-sitter-and-lsp)
- [Project Goals](#project-goals)
- [Install In One Command!](#install-in-one-command)
  - [Get the latest version of Neovim](#get-the-latest-version-of-neovim)
- [Getting started](#getting-started)
  - [Home screen](#home-screen)
  - [Leader and Whichkey](#leader-and-whichkey)
  - [Important Configuration files](#important-configuration-files)
- [Install your own plugins](#install-your-own-plugins)
  - [An example installation of the colorizer plugin](#an-example-installation-of-the-colorizer-plugin)
- [Using Packer](#using-packer)
  - [Packer commands](#packer-commands)
  - [Packer reports missing plugins](#packer-reports-missing-plugins)
- [Clipboard Support](#clipboard-support)
- [LSP](#lsp)
  - [Lsp errors](#lsp-errors)
    - [Understanding LspInfo](#understanding-lspinfo)
  - [Last resort](#last-resort)
- [Useful Programs](#useful-programs)
- [EFM server](#efm-server)
- [Formatters and Linters](#formatters-and-linters)
- [De-bugging](#de-bugging)
- [VSCodium](#vscodium)
- [Useful commands for troubleshooting](#useful-commands-for-troubleshooting)
- [Uninstalling](#uninstalling)
- [TODO](#todo)


# What's included?

DeathStar-vim provides neovim configuration files that take advantage of tree-sitter and language server protocol. The configuration is written in lua. 

## Why do I want tree-sitter and LSP?

* Normally, an editor uses regular expression parsing for things like highlighting and checking the syntax of your file.  Each time you make a change, the editor must re-parse the entire file.  Tree-sitter, on the other hand, transforms text into a syntax tree.  Each time you make a change, only the parts of the code that change need to be parsed.  This greatly improves the speed of parsing. This can make a huge difference when editing large files.

* Neovim 0.5 including language server protocol means your editor can provide: code actions, completions, formatting, navigating to definitions, renaming, etc.  The language server only has to be written once and will work on any editor that supports LSP.  Any improvements made to the language server will immediately be used by all editors that support LSP.

# Project Goals
* This project has been forked from [LunarVim].  While LunarVim targets users coming from VSCode, DeathStar-vim is for users coming from Vim or Neovim 0.4.

* This project will provide only the bare essentials for getting up and running with tree-sitter and lsp.

* This set of configuration files is meant to be a base for you to easily set up neovim as you like.  


# Installing

First back up your configurable files to a place of your choosing or do:
```bash
mv ~/.config/nvim ~/.config/nvim_bak

```

Then clone this repository
```bash
git clone https://github.com/ChristianChiarulli/LunarVim.git ~/.config/nvim
```

Then open neovim and run:
```bash
:PackerCompile
:PackerInstall
```

## Get the latest version of Neovim

Some operating systems package versions of Neovim 0.5.  You can install those or you can follow the steps below to compile from source.  Compiling from source is the recommended method.

First, get the dependencies. For distributions other than Ubuntu or Arch go [here](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites)
```bash
#Ubuntu
sudo apt-get install gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip build-essential
#Arch
sudo pacman -S base-devel cmake unzip ninja tree-sitter
```

Download and compile Neovim
```bash
cd ~
sudo rm -r neovim
git clone https://github.com/neovim/neovim
cd neovim
sudo make CMAKE_BUILD_TYPE=Release install
cd ~
sudo rm -r neovim
```
or if you are on Arch you can get it from the AUR
```bash
yay -S neovim-git
```

# Getting started

## Other key bindings
Other key bindings can be found in ~/.config/nvim/lua/keymappings.lua

If you already have a set of keybindings in vimscript that you prefer, source your vimscript file from ~/.config/nvim/init.lua  

Example:
```lua
vim.cmd('source ~/.config/nvim/vimscript/keymappings.vim')
```

Or you can translate your old bindings to lua and keep them in the provided keymappings file.  Follow the lua guide available [here](https://github.com/nanotee/nvim-lua-guide)

## Important Configuration files
| Path | Description |
|------|-------------|
|~/.config/nvim/lv-settings.lua      | The main settings file            |
|~/.config/nvim/lua/keymappings.lua  |  Key bindings           |
|~/.config/nvim/lua/plugins.lua      |  Add or remove plugins here           |

# Install your own plugins 
The steps for configuring your own plugin are:
1. Add the plugin to plugins.lua
2. If the plugin requires configuration.  Create a configuration file for it
3. If you created a configuration, require the file in init.lua
4. Use Packer to download and install the plugin

## An example installation of the colorizer plugin

* ~/.config/nvim/lua/plugins.lua

```lua
use {"norcalli/nvim-colorizer.lua", opt = true}
require_plugin("nvim-colorizer.lua")
```

* ~/.config/nvim/lua/lv-colorizer/init.lua

```lua
require'colorizer'.setup()
```

* ~/.config/nvim/init.lua

```lua
require('lv-colorizer')
```

```lua
:PackerCompile
:PackerInstall
```

# Using Packer
[Packer](https://github.com/wbthomason/packer.nvim) manages your installed plugins.  Any time you make changes to your list of plugins in ~/.config/nvim/lua/plugins.lua you must first run the command :PackerCompile then :PackerInstall. 
## Packer commands

```bash
-- You must run this or `PackerSync` whenever you make changes to your plugin configuration
:PackerCompile

-- Only install missing plugins
:PackerInstall

-- Update and install plugins
:PackerUpdate

-- Remove any disabled or unused plugins
:PackerClean

-- Performs `PackerClean` and then `PackerUpdate`
:PackerSync

-- View the status of your plugins
:PackerStatus
```

## Packer reports missing plugins

If you get an error message about missing plugins and the above commands do not work, remove the plugin directory and reinstall from scratch.
```bash
sudo rm -R ~/.local/share/nvim
:PackerCompile
:PackerInstall
```

# LSP

To install a supported language server:

```md
  :LspInstall <your_language_server>
```

See [LspInstall](https://github.com/kabouzeid/nvim-lspinstall) for more info.  

Most common languages should be supported out of the box, if yours is not I would welcome a PR

## Lsp errors
LunarVim lists the attached lsp server in the bottom status bar.  If it says 'No client connected' use :LspInfo to troubleshoot.

### Understanding LspInfo
1. Make sure there is a client attached to the buffer.  0 attached clients means lsp is not running
2. Active clients are clients in other files you have open
3. Clients that match the filetype will be listed.  If installed with :LspInstall <servername> the language servers will be installed.  
4. 'cmd' must be populated.  This is the language server executable.  If the 'cmd' isn't set or if it's not executable you won't be able to run the language server.  
  * In the example below 'efm-langserver' is the name of the binary that acts as the langserver.  If we run 'which efm-langserver' and we get a location to the executable, it means the langauge server is installed and available globally. 
  * If you know the command is installed AND you don't want to install it globally you'll need to manually set the cmd in the language server settings.  Configurations are stored in ~/.config/nvim/lua/lsp/  The settings will be stored in a file that matches the name of the language. e.g. python-ls.lua 
  * 'identified root' must also be populated.  Most language servers require you be inside a git repository for the root to be detected.  If you don't want to initialize the directory as a git repository, an empty .git/ folder will also work.  
5. Some language servers get set up on a per project basis so you may have to reinstall the language server when you move to a different project.

```md
    Configured servers: dartls, graphql, clangd, sumneko_lua, intelephense, kotlin_language_server, bashls, tsserver, tailwindls, solargraph, gopls,
~                  Neovim logs at: /Users/my-user/.cache/nvim/lsp.log
~
~                  0 client(s) attached to this buffer:
~
~                  0 active client(s):
~
~                  Clients that match the filetype python:
~
~                    Config: efm
~                      cmd:               /Users/my-user/.local/share/nvim/lspinstall/efm/efm-langserver
~                      cmd is executable: True
~                      identified root:   None
~                      custom handlers:
~
~                    Config: pyright
~                      cmd:               /Users/my-user/.local/share/nvim/lspinstall/python/node_modules/.bin/pyright-langserver --stdio
~                      cmd is executable: True
~                      identified root:   None
~                      custom handlers:   textDocument/publishDiagnostics
```

### Last resort
If you still have problems after implementing the above measures, rule out plugin problems with the following. This reinstalls your plugins and language servers.

```md
sudo rm -R ~/.local/share/nvim
:PackerCompile
:PackerInstall
:LspInstall python   <-- REPLACE WITH YOUR OWN LANGUAGE
:LspInstall efm      <-- REPLACE WITH YOUR OWN LANGUAGE
```

For a more in depth LSP support:
[link](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md)

# EFM server

In order for linters and formatters to work you will need to install
`efm-langserver`

```vim
:LspInstall efm
```

# Formatters and Linters

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

# Useful commands for troubleshooting
Whether you plan on using LunarVim as is or as a base to configure your own neovim, the following commands may be useful.  Any command that includes the symbol ':' is meant to be typed as a command in neovim. Make sure you're in normal mode not insert mode. 

| Command | Description |
|------|-------------|
| :checkhealth | Check the health of your neovim install            |
| :checkhealth \<pluginname>  |  Check the health of a plugin |
| nvim -v |   checks your neovim version           |
| nvim -V | vebose output when running neovim.  Prints out every event |
| :PackerCompile | Must be run when you make plugin changes. (or, alternately run :PackerSync) |
| :PackerInstall  | Only install missing plugins|
| :PackerUpdate | Update and install plugins |
|:PackerClean | Remove any disabled or unused plugins |
|:PackerSync | Performs 'PackerClean' then 'PackerUpdate' |
|:PackerStatus | List the status of your plugins |
|:LspInstall \<language> | Install a language server for a specific programming language |
| :LspInfo | List the status of active and configured language servers|
|:LspStart \<language> |     Start the requested server name. Will only succesfully start if the command detects a root directory matching the current config. Pass autostart = false to your .setup{} call for a language server if you would like to launch clients solely with this command. Defaults to all servers matching current buffer filetype.  |
|:LspStop | Stops all buffer clients|
|:LspRestart | Restarts all buffer clients|
|:map | List keybindings |
|:nmap | List normal mode keybindings |
|:vmap | List visual mode keybindings |
|:imap | List insert mode keybindings |
|:verbose imap \<keybinding> | Print out what a particular keybinding is mapped to|
|:messages | Print error messages.  Useful when messages get cut off|
|:scriptnames | List all sourced files|

# Uninstalling
Changed your mind about LunarVim?  To remove it entirely:
```lua
# Delete the configuration files
sudo rm -R ~/.config/nvim

# Delete the plugins
sudo rm -R ~/.local/share/nvim

# Delete the logs
sudo rm -R ~/.cache/nvim
```
