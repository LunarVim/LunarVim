# Overview

LunarVim strives to have basic LSP, linting, formatting and syntax support for all major languages.

If your language is not supported please do the following: 

- Check if LSP support is available in the lspconfig [repo](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md)

- Check if your linter or formatter is available in the null-ls [repo](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md)

- Check if your syntax is supported in the treesitter [repo](https://github.com/nvim-treesitter/nvim-treesitter)

If there is support for your language please file an issue with the LunarVim repo

If there is not file a ticket with one of the above repos

## LunarVim Info

Check LSP info, linter and formatter status for the currently opened file buffer

```lua
:LvimInfo
```

## LSP

To install a supported language server:

``` md
:LspInstall `<your_language_server>`
```

## Formatting 

Formatting is handled by Null-ls. It is off by default. Not all formatters are supported. For a list of supported formatters and linters [look here](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#available-sources). Formatters and linters are not installed with LunarVim and therefore they must be installed separately.

If you want to enable formatting for javascript for example, install the formatter and then add the following to your config.lua
```lua
lvim.lang.javascript.formatters = { { exe = "prettier" } }
```

If the name of your formatter or linter includes a hyphen `-`, replace it with an underscore `_`. Dashes are not valid identifiers in lua.

To enable format on save, add the following to your `~/.config/lvim/config.lua`

``` lua
lvim.format_on_save = true
```

## Linting
Linting is also handled by Null-ls. To set a linter for your language, install the linter and then enable the linter with configuration:

``` lua
lvim.lang.javascript.linters = { { exe = "eslint_d" } }
```

