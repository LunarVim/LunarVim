# JSON

## Install Syntax Highlighting

```vim
:TSInstall json
```

## Install Language Server

```vim
:LspInstall json
```

## Formatters

The configured formatter(s) must be installed separately.

Configuration in `~/.config/lvim/config.lua`:

```lua
lvim.lang.json.formatters = { { exe = 'json_tool│prettier│prettierd' } }
```
