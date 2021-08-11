# Vue

## Install Syntax Highlighting

```vim
:TSInstall vue
```

## Install Language Server

```vim
:LspInstall vue
```

## Formatters

The configured formatter(s) must be installed separately.

```lua
-- exe value can be "prettier", "prettierd", "eslint", or "eslint_d"
lvim.lang.vue.formatters = { { exe = "prettier" } }
```

Also combination of some prettier and eslint can be specified:

```lua
-- exe value can be "prettier", "prettierd", "eslint", or "eslint_d"
lvim.lang.vue.formatters = { { exe = "eslint"}, { exe = "prettier" } }
```

With `eslint` and `eslint_d`, the `--fix` functionality is used for formatting. 

## Linters

The configured linter must be installed separately.

```lua
-- exe value can be "eslint" or "eslint_d"
lvim.lang.vue.linters = { { exe = "eslint" } }
```

## LSP Settings

```lua
:NlspConfig vuels
```
