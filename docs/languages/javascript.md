# JavaScript

## Syntax highlighting

```vim
:TSInstall javascript
```

## Supported language servers

```lua
javascript = {
  "denols", "ember", "eslint", "eslintls", "rome", "stylelint_lsp", "tailwindcss", "tsserver"
  }
```

Only `tsserver` is enabled by default and the other servers need to be [manually configured](./README.md#manually-configured-servers).

## Supported formatters

```lua
javascript = { "deno", "eslint", "eslint_d", "prettier", "prettier_d_slim", "prettierd", "rustywind" }
```

The configured formatter(s) must be installed separately.

## Supported linters

```lua
javascript = { "eslint", "eslint_d" }
```

The configured linter(s) must be installed separately.

## Supported language servers

```lua
javascript = { "denols", "ember", "eslint", "eslintls", "rome", "stylelint_lsp", "tailwindcss", "tsserver" }
```
