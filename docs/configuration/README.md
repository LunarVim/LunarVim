# Configuration

You can configure LunarVim by using the configuration file located in `~/.config/lvim/config.lua`.  

To get started quickly, copy the sample configuration file

``` bash
cp ~/.local/share/lunarvim/lvim/utils/installer/config.example.lua ~/.config/lvim/config.lua
```

Many LunarVim internal settings are exposed through the `lvim` global object.
So see a list of all available settings, run this command from `~/.local/share/lunarvim/lvim` to generate an lv-settings.lua file.

``` bash
lvim --headless +'lua require("utils").generate_settings()' +qa && sort -o lv-settings.lua{,}
```

Here is a sample of the output.

``` lua
lvim.builtin.telescope.defaults.initial_mode = "insert"
lvim.builtin.telescope.defaults.layout_config.horizontal.mirror = false
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 120
lvim.builtin.telescope.defaults.layout_config.prompt_position = "bottom"
lvim.builtin.telescope.defaults.layout_config.vertical.mirror = false
lvim.builtin.telescope.defaults.layout_config.width = 0.75
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"

```

If you want to keep launching LunarVim with the nvim command, add an alias entry to your shell's config file: alias `nvim=lvim`. To temporarily revert to the default nvim prefix it with a backslash `\nvim`.  If you create this alias, you may also want to explicitly set your editor as well `export EDITOR='lvim'`.  This will tell command line tools like git to use LunarVim as your editor.  

