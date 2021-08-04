# Languages

LunarVim strives to have basic LSP, linting, formatting and syntax support for all major languages.

If your language is not supported please do the following: 

- Check if LSP support is available in the lspconfig repo

- Check if your linter or formatter is available in the null-ls repo

- Check if your syntax is supported in the treesitter repo

If there is support for your language please file an issue with the LunarVim repo

If there is not file a ticket with one of the above repos

## Formatting 

Formatting is handled by Null-ls it is off by default. Not all formatters are supported.  For a list of supported formatters and linters [look here](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#available-sources)

If you want to enable formatting, add the following to your config.lua
```lua
lvim.lang.typescriptreact.formatters = {
  {
    exe = "prettier",
    args = {},
  }
}
```

Define the formatter for your filetype. 
```lua
lvim.lang.typescript.formatters = {{}}
lvim.lang.typescriptreact.formatters = {{}}
lvim.lang.javascript.formatters = {{}}
lvim.lang.typescriptreact.formatters = {{}}

```

If the name of your formatter or linter includes a hyphen `-`, replace it with an underscore `_`. Dashes are not valid identifiers in lua.  LunarVim chooses to match the name of the formatter with the variable it's stored in.     

To enable format on save, add the following to your `config.lua`

``` lua
lvim.format_on_save = true
```

## Linting
Linting is handled by Null-ls.  To set a linter for your language:

``` lua
lvim.lang.typescriptreact.linters = {
  {
    exe = "eslint_d",
    args = {}, },
}
```

To enable linting on save:

``` lua
lvim.lint_on_save = true
```
