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

The configured formatter(s) must be installed separately.

Configuration in `~/.config/lvim/config.lua`:

```lua
-- exe value can be "black", "yapf", or "isort"
lvim.lang.python.formatters = { { exe = "black" } }
```

## Linters

The configured linter must be installed separately.

Configuration in `~/.config/lvim/config.lua`:

```lua
lvim.lang.python.linters = { { exe = "flake8" } }
```

## LSP Settings

```vim
:NlspConfig pyright
```

## Debugger

```vim
:DIInstall python
```

```lua
-- ~/.config/lvim/ftplugin/python.lua
local dap_install = require "dap-install"
dap_install.config("python_dbg", {})
```
