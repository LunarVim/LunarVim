# Python

## Install Syntax Highlighting

```vim
:TSInstall python
```

## Supported language servers

```lua
python = { "jedi_language_server", "pylsp", "pyright" }
```

    
## Supported formatters

```lua
python = { "autopep8", "black", "isort", "reorder-python-imports", "yapf" }
```
    
## Supported linters

```lua
python = { "flake8", "pylint" }
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
dap_install.config("python", {})
```
