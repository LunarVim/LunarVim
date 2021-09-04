# Default Plugins

These are the default plugins that are installed with LunarVim, here is a very brief discription of what they do, some commands and the LunarVim default key bindings.

## Plugin management

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

**'use-package' inspired plugin/package management for Neovim.**  


```:PackerInstall``` installs packages that have a lvim.plugins entry in ~/.config/lvim/config.lua  
```:PackerStatus``` Lists the installed plugins  
```:PackerUpdate``` fetches and installs updates to packages  

## Language Server Protocol

### [nvim.lspconfig](https://github.com/neovim/nvim-lspconfig)

**A collection of common configurations for Neovim's built-in language server client.**  

Automatically launching and initializing language servers that are installed on your system.  

```:LspInfo``` Language server diagnostics  


### [nvim-lspinstall](https://github.com/kabouzeid/nvim-lspinstall)

**Companion plugin for nvim-lspconfig to install language servers**  

can use tab completion with LspInstall to check for available language servers  

```:LspInstall <language>```  

### [nlsp.settings.nvim](https://github.com/tamago324/nlsp-settings.nvim)

**A plugin to configure Neovim LSP using json files like coc-settings.json.**  

## Highlighting, treesitter

### [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

**Easy way to use the tree-sitter interface  in Neovim and provide some basic functionality such as highlighting**  


```:TSInstall <language_to_install>```  tab to show available languages  
```:TSInfoInstallInfo```  check installation status  

see the nvim.treesitter documentation to see the supported languages  

## File explorer, treesitter

### [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)

**A File Explorer For Neovim Written In Lua** 


```<leader> e```   opens explorer,  \<spacebar> is default leader key in LunarVim  
```:q```   quit  
```g?```  help and key bindings 

## Project management

### [project.nvim](https://github.com/ahmedkhalf/project.nvim)

**all in one project management.** 

Finds the root of your project and changes the LunarVim working directory to the project root depending on the language, may use .git, Cargo.toml, etc
To overide this like a basic neovim:
set ```lvim.builtin.project.manual_mode = true``` in ~/.config/lv-settings.lua then remove the project.vim dir in ~/.local/share/lunarvim/site/pack/packer/start/ and reinstall with ```PackerInstall``` if you don't have the plugin LSP will break.

## Fuzzy file finder

### [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

**extendable fuzzy finder over lists, built on the latest features from neovim core**  

open with ```<leader> f```    , ```<spacebar> f``` if using LunarVim defaults

