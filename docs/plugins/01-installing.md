# Installing Plugins

Plugins are installed by adding snippets into the `lvim.plugins` table in your `config.lua` file.  Save (`:w` or `<leader>w`), and Packer will autoinstall the new plugins.

## Example

```lua
lvim.plugins = {
  {"lunarvim/colorschemes"},
  {"folke/tokyonight.nvim"}, 
}
```

Run `:PackerSync` to pull down updates for your existing plugins.
The plugins are stored at `~/.local/share/lunarvim/site/pack/packer`. The README's (and `docs/` folder if it exists) typically contain excellent documentation, so it may be worthwhile to create an alias for this directory.

## Removing Plugins

  Removing a plugin from the `lvim.plugin` table removes it from your configuration but not your system.  Any plugins left in the `start` directory will still autostart.  To remove them completely, run `:PackerClean`
