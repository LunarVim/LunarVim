# Go

## Install Syntax Highlighting

```vim
:TSInstall gopls
```

## Install Language Server

```vim
:LspInstall gopls
```

## Formatters

The configured formatter(s) must be installed separately.

Configuration in `~/.config/lvim/config.lua`:

```lua
-- exe value can be "gofmt", "goimports", or "gofumpt"
lvim.lang.go.formatters = {{ exe = "goimports" }}
```

## LSP Settings

```vim
:NlspConfig gopls
```

Configure `json` to use auto-completion

## Debugger

```vim
:DIInstall go_delve
```

```lua
-- ~/.config/lvim/ftplugin/go.lua
local dap_install = require "dap-install"
dap_install.config("go_delve", {})
```
