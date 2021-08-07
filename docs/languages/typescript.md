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

```lua
lvim.lang.typescript.formatters = {
  {
    exe = "prettier", -- can be prettierd, eslint or eslint_d as well
    args = {},
  },
}
lvim.lang.typescriptreact.formatters = 
  {
    exe = "prettier", -- can be prettierd, eslint or eslint_d as well
    args = {},
  },
}
```

The selected formatter(s) must be installed separately.

## Linters

```lua
lvim.lang.typescript.linters = {
  {
    exe = "eslint", -- can be eslint_d as well
    args = {}, 
  },
}
lvim.lang.typescriptreact.linters = {
  {
    exe = "eslint", -- can be eslint_d as well
    args = {}, 
  },
}
```

The selected linter(s) must be installed separately.

## LSP Settings

See [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tsserver) for more information about the tsserver language server configuration options.

E.g. modify the `root_dir` setup value:

```lua
lvim.lang.typescript.lsp.setup["root_dir"] = <new value>
```
