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

After that you can enable debugging

```lua
lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
  }
  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}", -- This configuration will launch the current file if used.
      pythonPath = function()
        local cwd = vim.fn.getenv "VIRTUAL_ENV"
        if vim.fn.executable(cwd .. "/bin/python") == 1 then
          return cwd .. "/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        else
          return "/usr/bin/python"
        end
      end,
    },
  }
end
```
