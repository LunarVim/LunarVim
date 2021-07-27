# Installing Plugins

You can easily install plugins using the options provided by packer.

Just add your plugin to the `lvim.plugins` table in your `lv-config.lua` file and save the file (don't quit or the operation will not run).

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
    }
}
```

After adding the following to your `lv-config.lua` just `:w` and the plugins will automatically install.
