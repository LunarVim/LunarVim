# Configuring a debugger

LunarVim uses nvim-dap for debugging. To set up your particular debugger, look here:
[link](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation)

## cpp

To set up a debug adapter for cpp, place this in your `config.lua`

```lua
lvim.builtin.dap.on_config_done = function(dap)
    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode',
      name = "lldb"
    }

    dap.configurations.cpp = {
        {
            name = "Launch",
            type = "lldb",
            request = "launch",
            program = "${workspaceFolder}/build/binary_name",
            cwd = "${workspaceFolder}/build",
            stopOnEntry = false,
            args = {},
            runInTerminal = false,
        },
    }
    dap.configurations.c = dap.configurations.cpp
end
```
