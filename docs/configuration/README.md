# Configuration

You can configure LunarVim by using the configuration file located in `~/.config/lvim/lv-config.lua`.  

To get started quickly, copy the sample configuration file

```
cp ~/.local/share/lunarvim/lvim/utils/installer/lv-config.example.lua ~/.config/lvim/lv-config.lua
```

Many LunarVim internal settings are exposed through the `lvim` global object.
So see a list of all available settings, run this command to generate a lv-settings.lua file.

```
lvim --headless +'lua require("lv-utils").generate_settings()' +qa && sort -o lv-settings.lua{,}
```

Here is a sample of the output.

```
lvim.builtin.telescope.defaults.initial_mode = "insert"
lvim.builtin.telescope.defaults.layout_config.horizontal.mirror = false
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 120
lvim.builtin.telescope.defaults.layout_config.prompt_position = "bottom"
lvim.builtin.telescope.defaults.layout_config.vertical.mirror = false
lvim.builtin.telescope.defaults.layout_config.width = 0.75
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"

```

