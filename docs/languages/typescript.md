# TypeScript

## Install Syntax Highlighting

```vim
:TSInstall typescript
```

## Install Language Server

```vim
:LspInstall typescript
```

Project root is recognized by having one of the folloing files/folders in the root directory of the project: `package.json`, `tsconfig.json`, `jsconfig.json`, `.git`

## Formatters

The configured formatter(s) must be installed separately.

Configuration in `~/.config/lvim/config.lua`:

```lua
-- exe value can be "prettier", "prettierd", "eslint", or "eslint_d"
lvim.lang.typescript.formatters = { { exe = "prettier" } }
lvim.lang.typescriptreact.formatters = lvim.lang.typescript.formatters
```

Also combination of some prettier and eslint can be specified:

```lua
-- exe value can be "prettier", "prettierd", "eslint", or "eslint_d"
lvim.lang.typescript.formatters = { { exe = "eslint"}, { exe = "prettier" } }
lvim.lang.typescriptreact.formatters = lvim.lang.typescript.formatters
```

With `eslint` and `eslint_d`, the `--fix` functionality is used for formatting. 

## Linters

The configured linter must be installed separately.

Configuration in `~/.config/lvim/config.lua`:

```lua
-- exe value can be "eslint" or "eslint_d"
lvim.lang.typescript.linters = { { exe = "eslint" } }
lvim.lang.typescriptreact.linters = lvim.lang.typescript.linters
```

## LSP Settings

See [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tsserver) for more information about the tsserver language server configuration options.

E.g. modify the `root_dir` setup value:

```lua
lvim.lang.typescript.lsp.setup["root_dir"] = <new value>
```
