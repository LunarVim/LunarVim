# TypeScript

## Syntax highlighting

```vim
:TSInstall typescript
:TSInstall tsx
```

## Supported language servers

```lua
typescript = { "angularls", "denols", "ember", "eslint", "eslintls", "rome", "stylelint_lsp", "tailwindcss", "tsserver" }
```

Only `tsserver` is enabled by default and the other servers need to be [manually configured](./README.md#manually-configured-servers).

### TypeScript standalone server (tsserver)

`tsserver` requires one of the following files/folders : `package.json`, [`tsconfig.json`](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html), [`jsconfig.json`](https://code.visualstudio.com/docs/languages/jsconfig) or `.git.` in the root directory of the project

See [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver) for more information about the tsserver language server configuration options.

## Supported formatters

```lua
typescript = { "deno", "eslint", "eslint_d", "prettier", "prettier_d_slim", "prettierd", "rustywind" }
```

The configured formatter(s) must be installed separately.

## Supported linters

```lua
typescript = { "eslint", "eslint_d" }
```

The configured linter(s) must be installed separately.
