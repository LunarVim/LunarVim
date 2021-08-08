# C/C++

## Install Syntax Highlighting

```vim
:TSInstall c
```

```vim
:TSInstall cpp
```

## Install Language Server

Install `clangd` language server

```vim
:LspInstall cpp
```

List of other [available language servers](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md). If `:LspInstall` does not have support for installing the language server, you need to install it separately.

## Formatters

`clangd` supports formatting. Optionally `uncrustify` and `clangd_format` can be used as a formatter. Optional formatter will disable language server formatter.

```lua
lvim.lang.c.formatters = {
  {
    exe = "clangd_format", -- can also be uncrustify
    args = {},
  },
}
lvim.lang.cpp.formatters = {
  {
    exe = "clangd_format", -- can also be uncrustify
    args = {},
  },
}
```

The selected formatter must be installed separately.

## LSP Settings

E.g. use of other language server:

```vim
lvim.lang.c.lsp.provider = "<LS identifier>"
lvim.lang.c.lsp.setup.cmd = { "<path to executable>", "arg1", "arg2" }
lvim.lang.cpp.lsp.provider = "<LS identifier>"
lvim.lang.cpp.lsp.setup.cmd = { "<path to executable>", "arg1", "arg2" }
```

`<LS identifier>` must be one supported by `nvim-lspconfig`. [List of available LSP  configs](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md)
