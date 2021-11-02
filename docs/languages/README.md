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

### Installing and updating a server

#### Automatic server installation

By default, most supported language servers will get automatically installed once you open the supported file-type, e.g, opening a Python file for the first time will install `Pyright` and configure it automatically for you.

- configuration option

```lua
lvim.lsp.automatic_servers_installation = true
```

Please refer to [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer) to see the updated full list of currently available servers.

To install a supported language server:

```md
:LspInstall `<your_language_server>`
```

You can also toggle `<:LspInstallInfo>` and interactively choose which servers to install.

### Manually-configured servers

`lvim.lsp.override` contains a list of servers that should **not** be automatically configured by default, for example only `tsserver` is allowed for JS-family languages, and when a language has more than one server available, then the most popular one is usually chosen. 

See the current list

```lua
:lua print(vim.inspect(lvim.lsp.override))
```

See the default list

```lua
:lua print(vim.inspect(require("lvim.lsp.config").override))
```

_Note: any changes to `lvim.lsp.override` **must** be followed by `:LvimCacheReset` to take effect._

### Server setup

LunarVim uses [filetype plugins](../configuration/07-ftplugin.md) to enable lazy-loading the setup of a language server. A template generator is used to create `ftplugin` files and populate them with the setup call.

- configuration option

```lua
lvim.lsp.templates_dir = join_paths(get_runtime_dir(), "after", "ftplugin")
```

A typical setup call with default arguments

```lua
-- edit this file by running `:lua vim.cmd("edit " .. lvim.lsp.templates_dir .. "/lua.lua"))`
require("lvim.lsp.manager").setup("sumneko_lua")
```

_Tip: You can quickly find these files by running `<leader>Lf` -> "Find LunarVim Files"_

#### Overriding the default setup options

Add the server you wish to configure manually to `lvim.lsp.override`

```lua
vim.list_extend(lvim.lsp.override, { "pyright" })
```

Now you can set it up manually using the builtin [lsp-manager](https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/lsp/manager.lua)

```lua
--- list of options that should take predence over any of LunarVim's defaults
--- check the lspconfig documentation for a list of all possible options
local opts = {} 
require("lvim.lsp.manager").setup("pyright", opts)
```

Alternatively, set it up using the `lspconfig` API directly

```lua
--- check the lspconfig documentation for a list of all possible options
local opts = {} 
require("lspconfig")["pyright"].setup(opts)
```

### Server settings

To set a setting for your language server:

```vim
:NlspConfig <TAB>
:NlspConfig <NAME_OF_LANGUAGE_SERVER>
```

This will create a file in `$LUNARVIM_CONFIG_DIR/lsp-settings`, to enable persistent changes. Refer to the documentation of [nlsp-settings](https://github.com/tamago324/nlsp-settings.nvim/blob/main/schemas/README.md) for a full updated list of supported language servers.

_Note: Make sure to install `jsonls` for autocompletion._

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

### Lazy-loading the formatter setup

By default, all null-ls providers are checked on startup. If you want to avoid that or want to only set up the provider when you opening the associated file-type,
then you can use [filetype plugins](../configuration/07-ftplugin.md) for this purpose.

Let's take `markdown` as an example:

1. create a file called `markdown.lua` in the `$LUNARVIM_CONFIG_DIR/ftplugin` folder
2. add the following snippet

```lua
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{exe = "prettier", filetypes = {"markdown"} }})
```

### Multi languages per formatter

```lua
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{exe = "prettier", filetypes = {"javascript", "json"} }})
```

_Note: removing the `filetypes` argument will allow the formatter to attach to all the default filetypes it supports._

If you start getting prompted to select some server as a formatter, then you will need to disable its formatting capabilities manually:

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

### Lazy-loading the linter setup

By default, all null-ls providers are checked on startup. If you want to avoid that or want to only set up the provider when you opening the associated file-type,
then you can use [filetype plugins](../configuration/07-ftplugin.md) for this purpose.

Let's take `typescript` as an example:

1. create a file called `typescript.lua` in the `$LUNARVIM_CONFIG_DIR/ftplugin` folder
2. add the following snippet

```lua
local linters = require "lvim.lsp.null-ls.linters"
linters.setup({{exe = "eslint_d", filetypes = { "typescript" } }})
```
