# Configuración

Para configurar LunarVim debes editar el archivo `~/.config/lvim/config.lua`.

También puedes tomar un archivo de ejemplo como guía, está incluido con la instalación, solo debes copiarlo a tu directorio de configuración de esta forma.

```bash
cp ~/.local/share/lunarvim/lvim/utils/installer/config.example.lua ~/.config/lvim/config.lua
```

Muchas configuraciones internas de LunarVim estan expuestas por medio del objeto global `lvim`.
Para ver una lista de todas las configuraciones disponibles, ejecuta el siguiente comando cualquiera de estos directorios `~/.config/lvim/` o `~/.local/share/lunarvim/lvim`, esto generará un archivo llamado lv-settings.lua como salida.

```bash
lvim --headless +'lua require("lvim.utils").generate_settings()' +qa && sort -o lv-settings.lua{,}
```

Aquí tienes un ejemplo del contenido del archivo generado.

```lua
lvim.builtin.telescope.defaults.initial_mode = "insert"
lvim.builtin.telescope.defaults.layout_config.horizontal.mirror = false
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 120
lvim.builtin.telescope.defaults.layout_config.prompt_position = "bottom"
lvim.builtin.telescope.defaults.layout_config.vertical.mirror = false
lvim.builtin.telescope.defaults.layout_config.width = 0.75
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
```

Si quieres abrir LunarVim usando el comando `nvim`, tendrás que añadir un alias a la configuración de tu shell de esta forma: `alias nvim=lvim`. Para revertir temporalmente este proceso, puedes hacerlo agregando un backslash al inicio de la linea así: `\nvim`. Si realizas este proceso, puede que también quieras establecer LunarVim como tu editor por defecto para las herramientas de terminal, tendrás que añadir esta linea a la configuración de tu shell: `export EDITOR='lvim'`.
