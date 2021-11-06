## Extended Configurations

Core plugins come pre-configured. Sometimes you may want to extend the configuration of these plugins to enable additional functionality. For example, if you want have autopairs automatically close your function definitions, you need to specify endwise rules.

LunarVim provides a way to extend the default configurations by adding the following to your configuration file. This specifies code to run after the configuration for autopairs has completed.

```lua
lvim.builtin.autopairs.on_config_done = function(module)
   --  YOUR_VALID_CONFIG_HERE
end
```

To complete our example. This is what our endwise rule might look like. When the trigger is typed `def`, autopairs will add a corresponding `end`.

```lua
lvim.builtin.autopairs.on_config_done = function(module)
  local endwise = require('nvim-autopairs.ts-rule').endwise
  module.add_rules(
    {
    endwise('def', 'end',nil, nil)
    })
end
```

The `module` variable contains the result of `require("nvim-autopairs")`

## Configuring debug adapters

Here is a sample configuration for setting up a debugger for cpp

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

## Configuring ToggleTerm

You can specify terminal applications to run with a keybind. LazyGit is the only command set up by default.

To set up an executable to run add the following to your `config.lua`

```lua
lvim.builtin.terminal.execs = {{"lazygit", "gg", "LazyGit"}, {"gdb", "tg", "GNU Debugger"}}
```

The table structure is `{{exec_path, keymap, name}}`

You can also do the following to append an executable

```lua
lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
```
