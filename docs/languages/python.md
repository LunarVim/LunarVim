# Python

## Install Syntax Highlighting

```vim
:TSInstall python
```

## Install Language Server

```vim
:LspInstall python
```

## Formatters

```lua
lvim.lang.python.formatters = {
  {
    exe = "black", -- can be yapf, or isort as well
    args = {},
  },
}
```

## Linters

```lua
lvim.lang.python.linters = {
  {
    exe = "flake8",
    args = {}, 
  },
}
```

## LSP Settings

```vim
:NlspConfig pyright
```

## Debugger

```vim
:DIInstall python_dbg
```

```lua
-- ~/.config/lvim/ftplugin/python.lua
local dap_install = require "dap-install"
dap_install.config("python_dbg", {})
```
