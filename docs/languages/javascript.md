# JavaScript

## Install Syntax Highlighting

```vim
:TSInstall javascript
```

## Install Language Server

JavaScript uses [TypeScript](/languages/typescript.html#install-language-server) language server.

## Formatters

The configured formatter(s) must be installed separately.

Configuration in `~/.config/lvim/config.lua`:

```lua
-- exe value can be "prettier", "prettierd", "eslint", or "eslint_d"
lvim.lang.javascript.formatters = { { exe = "prettier" } }
lvim.lang.javascriptreact.formatters = lvim.lang.javascript.formatters
```

Also combination of some prettier and eslint can be specified:

```lua
-- exe value can be "prettier", "prettierd", "eslint", or "eslint_d"
lvim.lang.javascript.formatters = { { exe = "eslint"}, { exe = "prettier" } }
lvim.lang.javascriptreact.formatters = lvim.lang.javascript.formatters
```

With `eslint` and `eslint_d`, the `--fix` functionality is used for formatting. 

## Linters

The configured linter must be installed separately.

Configuration in `~/.config/lvim/config.lua`:

```lua
-- exe value can be "eslint" or "eslint_d"
lvim.lang.javascript.linters = { { exe = "eslint" } }
lvim.lang.javascriptreact.linters = lvim.lang.javascript.linters
```

## LSP Settings

More information in [TypeScript](/languages/typescript.html#lsp-settings).

## Debugger

(TODO)
