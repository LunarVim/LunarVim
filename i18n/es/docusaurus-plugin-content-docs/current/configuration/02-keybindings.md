# Mapeo de teclas

Usa `<Leader>Lk` para ver los mapeos de teclas en LunarVim.

Para modificar un mapeo de tecla en LunarVim.

```lua
  -- X cierra un buffer
  lvim.keys.normal_mode["<S-x>"] = ":BufferClose<CR>"
```

Para eliminar mapeos de teclas establecidas en LunarVim.

```lua
  lvim.keys.normal_mode["<C-h>"] = false
  lvim.keys.normal_mode["<C-j>"] = false
  lvim.keys.normal_mode["<C-k>"] = false
  lvim.keys.normal_mode["<C-l>"] = false
```

### Mostrando que está mapeado
Usa `<Leader>Lk` para ver los mapeos de teclas en LunarVim.

Para verificar si una tecla en particular ya ha sido mapeada:

```lua
:verbose map <TAB>
```

- :nmap para mapeos en modo normal
- :vmap para mapeos en modo visual
- :imap para mapeos en modo inserción

O simplemente puedes mostrar todos los mapeos:

```lua
:map
```

## Mapeos para el explorador

Para ver los mapeos para el plugin de nvimtree. Asegurado de que estan dentro de un buffer de nvimtree y escribe `g?` para mostrar/ocultar la ayuda para el mapeo de teclas.

## Mapeos para LSP

TODO

lvim.lsp.buffer_mappings.normal_mode

## Mapeos para Whichkey

Para añadir o cambiar los mapeos de teclas para whichkey, debes usar `lvim.builtin.which_key.mappings`.

### Mapeo de una sola tecla

Para hacer un solo mapeo.

```lua
lvim.builtin.which_key.mappings["P"] = {
  "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Proyectos"
}
```

Para añadir una tecla a un submenú ya existente.

```lua
lvim.builtin.which_key.mappings["tP"] = {
  "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Proyectos"
}
```

### Mapeo de submenús

Puedes mapear un grupo de teclas dentro del mapeo de una tecla, esto es util para hacer submenús, por ejemplo; quieres hacer que `Definiciones` sea activado presionando `<Leader>td` y que  `Referencias` sea activado presionando `<Leader>tr`. Entonces debes hacer un submenú que se llame `Problema`de la siguiente forma.

```lua
lvim.builtin.which_key.mappings["t"] = {
  name = "Problema",
  r = { "<cmd>Trouble lsp_references<cr>", "Referencias" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definiciones" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticos" },
  q = { "<cmd>Trouble quickfix<cr>", "Arreglo Rapido" },
  l = { "<cmd>Trouble loclist<cr>", "Lista de rutas" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticos" },
}
```

### Reemplazar todos los mapeos de Whichkey

Para reemplazar todos los mapeos a tu gusto, debes cambiar tu configuración de esta forma.

```lua
lvim.builtin.which_key.mappings = {
  ["c"] = { "<cmd>BufferClose!<CR>", "Cerrar Buffer" },
  ["e"] = { "<cmd>lua require'core.nvimtree'.toggle_tree()<CR>", "Explorador" },
  ["h"] = { '<cmd>let @/=""<CR>', "Sin Resaltado" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compilar" },
    i = { "<cmd>PackerInstall<cr>", "Instalar" },
    r = { "<cmd>lua require('lv-utils').reload_lv_config()<cr>", "Recargar" },
    s = { "<cmd>PackerSync<cr>", "Sincronizar" },
    u = { "<cmd>PackerUpdate<cr>", "Actualizar" },
  },
}
```

## Tecla Lider

Por defecto, la tecla lider es `Espacio`. La puedes cambiar de la siguiente forma.

```lua
lvim.leader = "space"
```
