# Plugins

## Installing

Plugins are installed by adding snippets into the `lvim.plugins` table in your `config.lua` file. Save (`:w` or `<leader>w`), and Packer will autoinstall the new plugins.


```lua
lvim.plugins = {
  {"lunarvim/colorschemes"},
  {"folke/tokyonight.nvim"},
}
```

Run `:PackerSync` to pull down updates for your existing plugins.
The plugins are stored at `~/.local/share/lunarvim/site/pack/packer`. The README's (and `docs/` folder if it exists) typically contain excellent documentation, so it may be worthwhile to create an alias for this directory.

::: tip Notice
see which plugins are installed with `:PackerStatus`
:::

## Removing

Removing a plugin from the `lvim.plugin` table removes it from your configuration but not your system. Any plugins left in the `start` directory will still autostart. To remove them completely, run `:PackerClean`

## Configuration

```lua
lvim.builtin.lualine.active = true
lvim.builtin.dap.active = true
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.bufferline.active = true -- this is actually using romgrk/barbar.nvim
```

Settings for core plugins are accessible through `lvim.builtin`. You can press `TAB` to get autocomplete suggestions to explore these settings.

If a plugin is lazy-loaded and you disable it, you need to let Packer know about it by running `:PackerSync`.

**Example settings**

```lua
lvim.builtin.cmp.completion.keyword_length = 2
lvim.builtin.telescope.defaults.layout_config.width = 0.95
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75
```
