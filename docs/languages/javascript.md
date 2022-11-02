# JavaScript

## Syntax highlighting

```vim
:TSInstall javascript
```

## Supported language servers

```lua
{ "cssmodules_ls", "denols", "ember", "eslint", "glint", "quick_lint_js", "rome", "stylelint_lsp", "tailwindcss", "tsserver" }
```

Only `tsserver` and `tailwindcss` is enabled by default and the other servers need to be [manually configured](./README.md#manually-configured-servers).

## Supported formatters

```lua
{ "deno_fmt", "dprint", "eslint", "eslint_d", "prettier", "prettier_d_slim", "prettier_standard", "prettierd", "rome", "rustywind", "semistandardjs", "standardjs" }
```

The configured formatter(s) must be installed separately.

## Supported linters

```lua
{ "eslint", "eslint_d", "jshint", "semistandardjs", "standardjs", "xo" }
```

The configured linter(s) must be installed separately.
