# Javascript

## Install Syntax Highlighting

```vim
:TSInstall javascript
```

## Install Language Server

```vim
:LspInstall typescript
```

## Formatters

```lua
lvim.lang.javascript.formatters = {
  {
    exe = "prettier", -- can be prettierd eslint, or eslint_d as well
    args = {},
  },
}
```

## Linters

``` lua
lvim.lang.python.linters = {
  {
    exe = "eslint", -- can be eslint_d as well
    args = {}, 
  },
}
```

## LSP Settings

(TODO)

## Debugger

(TODO)

