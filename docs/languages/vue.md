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

```lua
lvim.lang.vue.formatters = {
  {
    exe = "prettier", -- can be prettierd, eslint or eslint_d as well
    args = {},
  },
}
```

The selected formatter must be installed separately.

## Linters

```lua
lvim.lang.vue.linters = {
  {
    exe = "eslint", -- can be eslint_d as well
    args = {}, 
  },
}
```

The selected linter must be installed separately.

## LSP Settings

```lua
:NlspConfig vuels
```
