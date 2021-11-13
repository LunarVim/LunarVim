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

Using delve directly:

```lua
-- ~/.config/lvim/ftplugin/go.lua
local dap_install = require "dap-install"
dap_install.config("go_delve", {})
```

Using the [vscode-go debug adapter](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go):

```lua
local dap = require "dap"
dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = {os.getenv('HOME') .. '/vscode-go/dist/debugAdapter.js'}; -- specify the path to the adapter
}
dap.configurations.go = {
  {
    type = "go",
    name = "Attach",
    request = "attach",
    processId = require("dap.utils").pick_process,
    program = "${workspaceFolder}",
    dlvToolPath = vim.fn.exepath('dlv')
  },
  {
    type = "go",
    name = "Debug curr file",
    request = "launch",
    program = "${file}",
    dlvToolPath = vim.fn.exepath('dlv')
  },
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${workspaceFolder}",
    dlvToolPath = vim.fn.exepath('dlv')
  },
  {
    type = "go",
    name = "Debug curr test",
    request = "launch",
    mode = "test",
    program = "${file}",
    dlvToolPath = vim.fn.exepath('dlv')
  },
  {
    type = "go",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${workspaceFolder}",
    dlvToolPath = vim.fn.exepath('dlv')
  },
}
```
