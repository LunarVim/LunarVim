# Overview

LunarVim strives to have support for all major languages. The is made possible by utilizing some of the great plugins in Neovim's ecosystem. Such plugins are [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), for LSP support, and [Null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) to provide support for handling external formatters, such as [prettier](https://github.com/prettier/prettier) and [eslint](https://github.com/eslint/eslint). Furthermore, LunarVim integrates with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) to provider rich syntax highlighting and other language parsing magic.

If your language is not supported please check the following links and file a ticket so we can

- Check if LSP support is available in the lspconfig [repo](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md)
- Check if your linter or formatter is available in the null-ls [repo](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md)
- Check if your syntax is supported in the treesitter [repo](https://github.com/nvim-treesitter/nvim-treesitter)

## At a glance

You can use the following commands to check some information about any language servers that you have configured.

- `:LvimInfo`

  - Contains information about all the servers attached to the buffer you are editing and their current capabilities, such as formatting and go-to definition support. It also includes information related to any linters and formatters that are, or can be, configured.
  - keybind: `<leader>Li`

- `:LspInfo`

  - Contains basic information about all the servers that are running.
  - keybind: `<leader>li`

- `:LspInstallInfo`

  - Contains information about all the servers that you can manage with [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer).
  - keybind: `<leader>lI`

## LSP support

### Automatic server installation

By default, most supported language servers ^[Only TSServer is configured by default for JS-family languages] will get automatically installed once you open the supported file-type, e.g, opening a Python file for the first time will install `Pyright` and configure it automatically for you.

- configuration option

```lua
lvim.lsp.automatic_servers_installation = true
```

Please refer to [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer) to see the updated full list of currently available servers.

### Installing and updating a server

To install a supported language server:

```md
:LspInstall `<your_language_server>`
```

You can also toggle `<:LspInstallInfo>` and interactively choose which servers to install.

### Server configuration

To set a configuration for your language server:

```vim
:NlspConfig <TAB>
:NlspConfig <NAME_OF_LANGUAGE_SERVER>
```

This will create a file in `~/.config/lvim/lsp-settings`, to enable persistent changes. Refer to the documentation of [nlsp-settings](https://github.com/tamago324/nlsp-settings.nvim/blob/main/schemas/README.md) for a full updated list of supported language servers.

_Note: Make sure to install `jsonls` for autocompletion._

### Overriding the default configuration

Add this to you `config.lua`

```lua
lvim.lsp.override = { "pyright" }
```

Now you can either set it up manually, or replace only a subset of LunarVim's default options

```lua
local opts = {} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("pyright", opts)
```

### Blacklisting a server

If you want to exclude a certain server while maintaining the auto-installation functionality then you can choose to override it. This will prevent it from being re-installed again and will also mean that you have to configure it manually.

## Formatting

To enable formatting for `javascript` for example, add the following to your `config.lua`

```lua
lvim.lang.javascript.formatters = { { exe = "prettier" } }
```

_Note: Formatters' installation is not managed by LunarVim. Refer to the each tool's respective manual for installation steps._

### Custom arguments

It's also possible to add custom arguments for each formatter.

```lua
lvim.lang.javascript.formatters = { { exe = "prettier", args = { "--print-with", "100" } } }

```

_Note: remember that arguments cannot contains spaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`._

### Multi formatters per language

```lua
lvim.lang.python.formatters = { { exe = "black" }, { exe = "isort" } }
```

### Multi languages per formatter

```lua
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{exe = "prettier", filetypes = {"javascript", "json"} }})
```

_Note: removing the `filetypes` argument will allow the formatter to attach to all the default filetypes it supports._

This method will not disable the formatting capability of the respective language server. Thus, you might start getting prompted to select it as a formatter. You need to disable this capability manually to avoid that.

```lua
-- here's an example to disable formatting in "tsserver" and "jsonls"
lvim.lsp.on_attach_callback = function(client, _)
  if client.name == "tsserver" or client.name == "jsonls" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end
```

### Formatting on save

This is controlled by an auto-command and is to true by default.

- configuration option

```lua
lvim.format_on_save = true
```

## Linting

To enable a linter for `bash` for example, add the following to your `config.lua`

```lua
lvim.lang.sh.linters = { { exe = "shellcheck" } }
```

_Note: linters' installation is not managed by LunarVim. Refer to the each tool's respective manual for installation steps._

### Custom arguments

It's also possible to add custom arguments for each linter.

```lua
lvim.lang.sh.linters = { { exe = "shellcheck", args = { "--sverity", "error" } } }

```

_Note: remember that arguments cannot contains spaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`._

### Multi formatters per language

```lua
lvim.lang.python.linters = { { exe = "flake8" }, { exe = "pylint" } }
```

### Multi languages per formatter

```lua
local linters = require "lvim.lsp.null-ls.linters"
linters.setup({{exe = "eslint", filetypes = {"javascript", "typescript", "vue"} }})
```

_Note: removing the `filetypes` argument will allow the linter to attach to all the default filetypes it supports._
