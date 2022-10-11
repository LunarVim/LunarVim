# C/C++

## Install Syntax Highlighting

```vim
:TSInstall c
```

```vim
:TSInstall cpp
```

## Install Language Server

```vim
:LspInstall clangd
```

Check the official documentation for other methods <https://clangd.llvm.org/installation>.

## Formatters

`clangd` language server supports formatting using `clang_format` by default. Optionally, you can use `uncrustify` or `clang-format` directly if you don't want to use `clangd`.

Configuration in `~/.config/lvim/config.lua`

```lua
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { exe = "uncrustify", args = {} } }
```

The selected formatter must be installed separately.
