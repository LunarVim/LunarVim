# Barra de Estado

LunarVim usa `lualine` como barra de estado predeterminada.

La configuración esta barra de estado, es identica a le de lualine. Para mas información visita [Lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/README.md).

Adicionalmente, LunarVim te ofrece multiples diseños y componentes para tu barra.

## Diseños

Hay tres opciones de diseño que puedes establecer en tu LunarVim.

- lvim
  > El diseño por defecto de LunarVim.
- default
  > El diseño por defecto de lualine.
- none
  > Es un diseño vacio.

Para cambiar el diseño, basta con agregar la siguiente linea a la configuración. 

```lua
lvim.builtin.lualine.style = "default" -- o "none"
```

<br />

## Componentes

Puedes usar cualquier componente proporcionado por `lualine` o `LunarVim` .

**Componentes de LunarVim**

`mode`, `branch`, `filename`, `diff`, `python_env`, `diagnostics`, `treesitter`, `lsp`, `location`, `progress`, `spaces`, `encoding`, `filetype`, `scrollbar`

Puedes cambiar y combinar estos componentes a tu gusto, a continuación se muestran ejemplos de algunas de las combinaciones que se pueden hacer.

- Para establecer el componente `"diff"` de `lualine` a la sección c del diseño `"default"`.

```lua
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.sections.lualine_c = { "diff" }
```

- Para establecer los componentes de `"spaces" y "location"` de LunarVim a la sección y y el componentes de `"mode"` de lualine a la sección a con el diseño `"lvim"`.

```lua
-- No es necesario establecer el diseño = "lvim"
local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_y = {
  components.spaces,
  components.location
}
```

<br />

## Tema

LunarVim detecta automaticamente el esquema de colores que tienes activado y lo establece como el tema de la barra de estado.

Para cambiar el esquema de colores, puedes revisar [Esquemas de Colores](./03-colorschemes.md).

Si no tienes un tema compatible con `lualine`, el sistema te mostrará automaticamente el tema por defecto de `lualine`.

Si quieres usar un tema diferente a tu esquema de colores en tu barra de estado, puedes seleccionarlo manualmente de esta forma.

```lua
lvim.builtin.lualine.options.theme = "gruvbox"
```

También puedes personalizar un tema ya existente.
```lua
local custom_gruvbox = require "lualine.themes.gruvbox_dark"
custom_gruvbox.insert.b = { fg = custom_gruvbox.insert.a.bg, gui = "bold" }
custom_gruvbox.visual.b = { fg = custom_gruvbox.visual.a.bg, gui = "bold" }
custom_gruvbox.replace.b = { fg = custom_gruvbox.replace.a.bg, gui = "bold" }
custom_gruvbox.command.b = { fg = custom_gruvbox.command.a.bg, gui = "bold" }

lvim.builtin.lualine.options.theme = custom_gruvbox
```

Puedes crear tu propio tema, debes seguir el siguiente esquema para que funcione.

```lua
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

La función de callback está disponible para darle mas flexibilidad a la configuración.

Va a ejecutarse automaticamente cuando la configuración allá sido aplicada, a continuación encuentras un ejemplo de esta función.

```lua
lvim.builtin.lualine.on_config_done = function(lualine)
  local config = lualine.get_config()
  local components = require "core.lualine.components"

  config.sections.lualine_x[3].color.bg = "#2c2c2c"
  table.remove(config.sections.lualine_x, 2) -- Elimina el icono de treesitter
  table.insert(config.sections.lualine_x, components.location)
  lualine.setup(config)
end
```
Si quieres profundizar más en esta configuración, puedes tomar la [configuración de jimcornmell](https://github.com/jimcornmell/lvim/blob/main/lua/user/lualine.lua) como referencia.
