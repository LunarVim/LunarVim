# Languages

LunarVim strives to have basic LSP, linting, formatting and syntax support for all major languages.

If your language is not supported please do the following: 

- Check if LSP support is available in the lspconfig repo

- Check if your linter or formatter is available in the null-ls repo

- Check if your syntax is supported in the treesitter repo

If there is support for your language please file an issue with the LunarVim repo

If there is not file a ticket with one of the above repos

## Formatting 

Formatting is handled by by your language server or Null-ls. Not all formatters are supported.  For a list of supported formatters and linters [look here](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#available-sources)

The language server will provide basic formatting.  If you need to use a specific formatting tool, set it with. 
``` lua
lvim.lang.cpp.formatter.exe = "asmfmt"
```
To enable format on save, add the following to your `lv-config.lua`

``` lua
lvim.format_on_save = true
```

## Linting
Linting is handled by Null-ls.  To set a linter for your language:

``` lua
lvim.lang.cpp.linters = {"cppcheck","clangtidy"}
```

To enable linting on save:

``` lua
lvim.lint_on_save = true
```
