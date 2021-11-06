# Go

## Install Syntax Highlighting

```vim
:TSInstall gopls
```

## Supported language servers

```lua
go = { "gopls" }
```

## Supported formatters

```lua
go = { "gofmt", "gofumpt", "goimports", "golines" }
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
