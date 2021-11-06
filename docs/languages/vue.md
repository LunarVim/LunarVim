# Vue

## Syntax highlighting

```vim
:TSInstall vue
```

## Supported language servers

```lua
vue = { "eslint", "stylelint_lsp", "tailwindcss", "volar", "vuels" },
```

Only `vuels` is enabled by default and the other servers need to be [manually configured](./README.md#manually-configured-servers).

## Supported formatters

```lua
vue = { "eslint", "eslint_d", "prettier", "prettier_d_slim", "prettierd", "rustywind" }
```

## Supported linters

```lua
vue = { "eslint", "eslint_d" }
```

## LSP Settings

```lua
:NlspConfig vuels
```
