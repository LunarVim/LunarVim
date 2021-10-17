# Default Plugins

This page lists the default plugins installed Lunavim including descriptions, important commands and default keybindings. This page only lists minimal information for each plugin. Go to the project page for each plugin to read the full documentation.

## Plugin management

**[packer.nvim](https://github.com/wbthomason/packer.nvim): Plugin/package management for Neovim.**

| Command          | Description                                                                   |
| ---------------- | ----------------------------------------------------------------------------- |
| `:PackerInstall` | Installs packages that have a lvim.plugins entry in ~/.config/lvim/config.lua |
| `:PackerInstall` | Installs packages that have a lvim.plugins entry in ~/.config/lvim/config.lua |
| `:PackerStatus`  | Lists the installed plugins                                                   |
| `:PackerUpdate`  | Fetches and installs updates to packages                                      |
| `:PackerClean`   | Removes any disabled or no longer managed plugins                             |
| `:PackerCompile` | Compile lazy-loader code and save to path                                     |
| `:PackerSync`    | Performs `:PackerUpdate` and `:PackerCompile`                                 |

## Language Server Protocol

**[nvim.lspconfig](https://github.com/neovim/nvim-lspconfig): A collection of common configurations for Neovim's built-in language server client.**

Automatically launch and initialize language servers

| Command    | Description                 |
| ---------- | --------------------------- |
| `:LspInfo` | Language server diagnostics |

**[nvim-lspinstall](https://github.com/kabouzeid/nvim-lspinstall): Companion plugin for nvim-lspconfig to install language servers**

Use tab completion with LspInstall to check for available language servers

| Command                  | Description                                       |
| ------------------------ | ------------------------------------------------- |
| `:LspInstall <language>` | Installs a language server for the given language |

**[nlsp.settings.nvim](https://github.com/tamago324/nlsp-settings.nvim): A plugin to configure Neovim LSP using json files like coc-settings.json.**

| Command                                 | Description                                           |
| --------------------------------------- | ----------------------------------------------------- |
| `:NlspConfig <NAME_OF_LANGUAGE_SERVER>` | Creates a configuration file for your language server |

See [Language Server Configuration](./02-after-install.md#language-server-configuration)

## Language parser

**[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Easy way to use the tree-sitter interface in Neovim to parse languages**

Provides basic syntax features like syntax highlighting and code folding. Allows other plugins to use the parsed syntax tree for other purposes, e.g. nvim-autopairs, nvim-comment, etc

| Command                            | Description                     |
| ---------------------------------- | ------------------------------- |
| `:TSInstall <language_to_install>` | Tab to show available languages |
| `:TSInstallInfo`                   | Check installation status       |

Consult the nvim.treesitter documentation to see which languages are [supported](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)

## Comments

**[nvim-comment](https://github.com/terrortylor/nvim-comment): Toggle comments in Neovim**

| Command      | Description                                      |
| ------------ | ------------------------------------------------ |
| `gcc`        | Comment line                                     |
| `gc{motion}` | comment/uncomment selection defined by a motion  |
| `gcip`       | comment/uncomment a paragraph                    |
| `gc4w`       | comment/uncomment current line                   |
| `gc4j`       | comment/uncomment 4 lines below the current line |

## File explorer

**[nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua) A File Explorer For Neovim Written In Lua**

| Command      | Description                                                       |
| ------------ | ----------------------------------------------------------------- |
| `<leader> e` | Opens explorer, \<spacebar> is the default leader key in LunarVim |
| `:q`         | Quit                                                              |
| `g?`         | Toggle help and key bindings.                                     |

## Project management

**[project.nvim](https://github.com/ahmedkhalf/project.nvim) All in one project management.**

Finds the root of your project and changes the LunarVim working directory to the project root depending on the language, may use .git, Cargo.toml, etc

## Fuzzy file finder

**[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): Extendable fuzzy finder over lists, built on the latest features from neovim core**

| Command        | Description                |
| -------------- | -------------------------- |
| `<leader> f`   | Opens file search          |
| `<spacebar> f` | If using LunarVim defaults |

## Completion

**[nvim-cmp](https://github.com/hrsh7th/nvim-cmp): A completion engine plugin for neovim written in Lua.**

## Snippets

**[LuaSnip](https://github.com/L3MON4D3/LuaSnip): Provides a snippet engine for neovim written in Lua.**

View example configurations [here](https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua)
View the documentation with `:help luasnip`

**[friendly-snippets](https://github.com/rafamadriz/friendly-snippets): A collection of snippets for different programming languages.**

LuaSnip uses friendly-snippets as it's snippet library.

## Auto-Pair closing brackets

**[nvim-autopairs](Autopairs): Provides automatic closing of brackets.**

## Git

**[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): Provides visual indicators for which lines have changed since the last commit**

Adds commands for staging git hunks.

| Command      | Description         |
| ------------ | ------------------- |
| `<Leader>gj` | Go to next Hunk     |
| `<Leader>gk` | Go to previous Hunk |
| `<Leader>gl` | Show git blame      |
| `<Leader>gp` | Preview hunk        |
| `<Leader>gr` | Reset hunk          |
| `<Leader>gR` | Reset buffer        |
| `<Leader>gs` | Stage hunk          |
| `<Leader>gu` | Unstage hunk        |

## Keybindings

**[which-key](https://github.com/folke/which-key.nvim): Displays popup with possible key bindings.**

Triggered by default with `Spacebar`. The speed whichkey opens is defined by `timeoutlen`. LunarVim defines a short `timeoutlen` of `100ms`. Some plugins might require a longer `timeoutlen` to work properly. The following command redefines the timeoutlen to half a second.

```lua
vim.opt.timeoutlen = 500
```

## Icons

**[nvim-web-devicons](kyazdani42/nvim-web-devicons): Provides icons for use with some plugins**

## Status and Bufferline

**[barbar.nvim](https://github.com/romgrk/barbar.nvim): barbar.nvim is a tabline plugin with re-orderable, auto-sizing, clickable tabs.**

| Command | Description           |
| ------- | --------------------- |
| `<S-l>` | Go to next buffer     |
| `<S-h>`  | Go to previous buffer |

**[lualine](https://github.com/hoob3rt/lualine.nvim): A blazing fast and easy to configure neovim statusline written in pure lua.**

[Go here](../configuration/06-statusline.md) for more information on configuration

## Terminal

**[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim): A neovim plugin to persist and toggle multiple terminals during an editing session**

| Command | Description     |
| ------- | --------------- |
| `<C-t>` | Toggle terminal |

Toggleterm can be used to launch command line programs. By default `gg` launches `LazyGit` assuming it is installed on your system. Other terminal executables can be added with:

```lua
    -- Add executables to config.lua
    -- { exec, keymap, name}
     lvim.builtin.terminal.execs = {{}} to overwrite
     lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
```

## Dashboard

**[dashboard-nvim](https://github.com/glepnir/dashboard-nvim): Provides a start screen with useful options.**

## Debugging

**[nvim-dap](https://github.com/mfussenegger/nvim-dap): nvim-dap is a Debug Adapter Protocol client implementation for Neovim**

For more information type the following commands

```lua
:help dap.txt
:help dap-adapter
:help dap-configuration
```

or go to the [Debug-Adapter installation wiki](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation)

**[DAPInstall](https://github.com/Pocco81/DAPInstall.nvim) Provides a way to manage installation, configuration, and setup of debuggers.**

| Command                  | Description                                  |
| ------------------------ | -------------------------------------------- |
| `:DIInstall <debugger>`  | Checks dependencies and installs \<debugger> |
| `:DIUnistall <debugger>` | Uninstalls \<debugger>                       |
| `:DIList`                | Lists installed debuggers                    |
