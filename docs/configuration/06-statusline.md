# Statusline
LunarVim uses `lualine` as a default statusline.

Configuration is same as that of lualine with full support. See [Lualine README.md](https://github.com/shadmansaleh/lualine.nvim/blob/master/README.md)

In addition, LunarVim provides predefined styles(layout) and components. 

## Style
There are three style options LunarVim accepts,
- lvim   
> LunarVim's default layout
- default 
> Lualine's default layout
- none
> Empty layout

To set style other than `"lvim" style`,
```lua
lvim.builtin.lualine.style = "default" -- or "none"
```

<br />

## Component
You can use any component that `lualine` provides and `LunarVim` provides.

**LunarVim's components**

`mode`, `branch`, `filename`, `diff`, `python_env`, `diagnostics`, `treesitter`, `lsp`, `location`, `progress`, `spaces`, `encoding`, `filetype`, `scrollbar`


To set `lualine's "diff"` component to section c of `"default" style`,
``` lua
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.sections.lualine_c = { "diff" }
```

To set `LunarVim's "spaces" and "location"` components to section y and `lualine's "mode"` component to section a of `"lvim" style`,
``` lua
-- no need to set style = "lvim"
local components = require("core.lualine.components")

lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_y = { 
  components.spaces, 
  components.location 
}
```
<br />


## Theme
LunarVim automatically detects current colorscheme and set it as theme.

To change your colorscheme, see [Colorscheme](./03-colorschemes.md)

If there is no matching theme, it will fallback to `"auto"` theme provided by lualine.

In case you want to use different theme, set it manually,
``` lua
lvim.builtin.lualine.options.theme = "gruvbox"
```

To customize existing theme,
``` lua
custom_gruvbox = require "lualine.themes.gruvbox_dark"
custom_gruvbox.insert.b = { fg = custom_gruvbox.insert.a.bg, gui = "bold" }
custom_gruvbox.visual.b = { fg = custom_gruvbox.visual.a.bg, gui = "bold" }
custom_gruvbox.replace.b = { fg = custom_gruvbox.replace.a.bg, gui = "bold" }
custom_gruvbox.command.b = { fg = custom_gruvbox.command.a.bg, gui = "bold" }

lvim.builtin.lualine.options.theme = custom_gruvbox
```

To create your own theme,
``` lua
local colors = {
  color2 = "#0f1419",
  color3 = "#ffee99",
  color4 = "#e6e1cf",
  color5 = "#14191f",
  color13 = "#b8cc52",
  color10 = "#36a3d9",
  color8 = "#f07178",
  color9 = "#3e4b59",
}

lvim.builtin.lualine.options.theme = {
  normal = {
    c = { fg = colors.color9, bg = colors.color2 },
    a = { fg = colors.color2, bg = colors.color10, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  insert = {
    a = { fg = colors.color2, bg = colors.color13, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  visual = {
    a = { fg = colors.color2, bg = colors.color3, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  replace = {
    a = { fg = colors.color2, bg = colors.color8, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  inactive = {
    c = { fg = colors.color4, bg = colors.color2 },
    a = { fg = colors.color4, bg = colors.color5, gui = "bold" },
    b = { fg = colors.color4, bg = colors.color5 },
  },
}
```
<br />

## Callback
Callback function is available for more flexibility.

It will run when configuration is done,

``` lua
lvim.builtin.lualine.on_config_done = function(lualine)
  local config = lualine.get_config()
  local components = require "core.lualine.components"
  
  config.sections.lualine_x[3].color.bg = "#2c2c2c"
  table.remove(config.sections.lualine_x, 2) -- remove treesitter icon 
  table.insert(config.sections.lualine_x, components.location)
  lualine.setup(config)
end
```

If you want to go way beyond with configuration, check [jimcornmell's setup](https://github.com/jimcornmell/lvim/blob/main/lua/user/lualine.lua) as a reference.
