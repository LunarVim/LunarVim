# Installing Plugins

You can easily install plugins using the options provided by packer.

Just add your plugin to the `lvim.plugins` table in your `lv-config.lua` file and save the file (don't quit or the operation will not run). You can also run `:PackerSync` to pull down updates for your plugins.

After adding the following to your `lv-config.lua` just `:w` and the plugins will automatically install.

## Example

```lua
lvim.plugins = {
    {"lunarvim/colorschemes"},
    {"folke/tokyonight.nvim"}, 
    {
        "ray-x/lsp_signature.nvim",
        config = function() 
          require"lsp_signature".on_attach() 
        end,
        event = "InsertEnter"
    },
}
```


# Core plugins
LunarVim comes bundled with a small set of default plugins.  A few plugins are disabled by default.  To enable a plugin, add an entry for it in your personal configuration file.  To see which plugins are installed run `:PackerStatus`

```lua
lvim.builtin.galaxyline.active = true
lvim.builtin.dap.active = true
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
```

To learn how to extend the configuration of these core plugins [go here](./extending-configuration-for-core-plugins.md)

# Removing Plugins

Removing a plugin from the `lvim.plugin` table removes it from your configuration but not your system.  Any plugins in the `start` directory will still autostart.  To remove them completely, run `:PackerClean`
