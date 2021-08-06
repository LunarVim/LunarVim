# Core plugins

Toggle builtin plugins:

```lua
lvim.builtin.galaxyline.active = true
lvim.builtin.dap.active = true
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.bufferline = true
```

Settings for core plugins are accessible through `lvim.builtin`. You can press `TAB` to get autocomplete suggestions to explore these settings.

Example settings
``` lua
lvim.builtin.compe.allow_prefix_unmatch = false
lvim.builtin.compe.autocomplete = true
lvim.builtin.compe.debug = false
lvim.builtin.telescope.defaults.layout_config.width = 0.95
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75
```

To see which plugins are installed run `:PackerStatus`


