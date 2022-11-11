# FTPlugin (Plugin para tipo de archivo)

## Descripción

De acuerdo con `:h ftplugin`

> Un plugin para tipo de archivo es como un plugin global, excepto que las opciones y mapeos
> solo aplican para el buffer actual.

Un ejemplo para una configuración de este tipo puede ser la siguiente; vamos a
modificar los valores de `shiftwidth` y `tabstop` pero solo para los archivos de extensión `C`.

```lua
-- Crea un archivo en la siguiente ruta $LUNARVIM_CONFIG_DIR/after/ftplugin/c.lua
vim.cmd("setlocal tabstop=4 shiftwidth=4")
```
