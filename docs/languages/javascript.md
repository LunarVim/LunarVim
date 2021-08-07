# JavaScript

## Install Syntax Highlighting

```vim
:TSInstall javascript
```

## Install Language Server

JavaScript uses [TypeScript](/languages/typescript.html#install-language-server) language server.

## Formatters

```lua
lvim.lang.javascript.formatters = {
  {
    exe = "prettier", -- can be prettierd eslint, or eslint_d as well
    args = {},
  },
}
lvim.lang.javascriptreact.formatters = {
  {
    exe = "prettier", -- can be prettierd eslint, or eslint_d as well
    args = {},
  },
}
```

The selected formatter(s) must be installed separately.

## Linters

```lua
lvim.lang.javascript.linters = {
  {
    exe = "eslint", -- can be eslint_d as well
    args = {}, 
  },
}
lvim.lang.javascriptreact.linters = {
  {
    exe = "eslint", -- can be eslint_d as well
    args = {}, 
  },
}
```

The selected linter(s) must be installed separately.

## LSP Settings

More information in [TypeScript](/languages/typescript.html#lsp-settings).

## Debugger

(TODO)
