# Esquemas de Colores

## Cambiar Colores

Para cambiar el esquema de colores rapidamente, escribe el siguiente comando:

```vim
:Telescope colorscheme
```

También puedes presionar  `Espacio` `s` `p` para tener una vista previa de los esquemas de colores.

Para cambiar el esquema de colores de manera permanente, tienes que modificar el archivo `config.lua`.

```lua
lvim.colorscheme = 'desert'
```

## Instalar Esquema de Colores

Puedes añadir el esquema de colores que quieras. Solo debes añadir el plugin con el esquema de colores de tu preferencia. Para más información sobre como instalar plugins [revisa aqui. ](../plugins/)

[Aqui tienes una lista](https://github.com/rockerBOO/awesome-neovim#colorscheme) de esquemas de colores con soporte para coloreado de sintaxis.

## Ventanas Transparentes

Si estas usando ventanas transparentes, tienes que activar esta opción.

```lua
lvim.transparent_window = true
```

Eso habilita las siguientes configuraciones.

```lua
cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
cmd "au ColorScheme * hi NormalNC ctermbg=none guibg=none"
cmd "au ColorScheme * hi MsgArea ctermbg=none guibg=none"
cmd "au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none"
cmd "au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none"
cmd "let &fcs='eob: '"
```
<iframe width="560" height="315" src="https://www.youtube.com/embed/OOr1qM17Lds" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="1"></iframe>
