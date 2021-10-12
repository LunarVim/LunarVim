# FTPlugin (filetype plugin)

## Description

From `:h ftplugin`

> A filetype plugin is like a global plugin, except that it sets options and
> defines mappings for the current buffer only.

Example for setting specific `shiftwidth` and `tabstop` that only apply for `C` file-types.

```lua
-- create a file at $LUNARVIM_CONFIG_DIR/ftplugin/c.lua
vim.cmd("setlocal tabstop=4 shiftwidth=4")
```

