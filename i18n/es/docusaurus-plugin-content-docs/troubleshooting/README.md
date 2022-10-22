# Instalación

## General

1.  Asegúrate de que tienes una versión reciente de Neovim con soporte para `luajit`. Al visualizar la información sobre la versión que tienes `nvim -v` debe incluir una línea para: `LuaJIT`.
2.  Asegúrate de que todas las dependencias enumeradas en el [Manual de instalación](#manual-install) están realmente instaladas en tu sistema.

## No se puede ejecutar `lvim`.

Asegúrese de que `lvim` está disponible y es ejecutable en tu path.
Puedes comprobar los resultados de estos comandos para verificar eso

```shell
which lvim
stat "$(which lvim)"
cat "$(which lvim)"
```

Si tienes errores con cualquiera de los comandos anteriores, entonces tienes que arreglarlo manualmente o reinstalar el binario de nuevo.

```shell
cd <lunarvim-repo> # Esto esta en  `~/.local/share/lunarvim/lvim` por defecto
bash utils/installer/install_bin.sh
```

## Errores obtenidos después de una actualización

### Errores con el caché

Esto puede ser el resultado de viejos archivos de caché que necesitan ser reiniciados. LunarVim hace uso de [impatients's](https://github.com/lewis6991/impatient.nvim) para optimizar el procedimiento de arranque y ofrecer una experiencia ágil.

1. mientras corre LunarVim: `:LvimCacheReset`
2. desde el CLI: `lvim +LvimCacheReset`

### Plugin issue

Otra razón común para tales errores es debido a que el Packer no puede restaurar completamente una instantánea (snapshot). Esto puede deberse a múltiples razones, pero lo más común es que haya un cambio que generara una ruptura en algún plugin, o que `git` se niegue a sacar una actualización de un plugin porque [no puede avanzar con seguridad a la rama actual](https://blog.sffc.xyz/post/185195398930/why-you-should-use-git-pull-ff-only-git-is-a).

La forma más fácil de resolver esto es actualizar manualmente (es probable que se requiera un reajuste/rebase ) en el plugin culpable, que debería estar ubicado en [Packer's package-root](https://github.com/wbthomason/packer.nvim/blob/4dedd3b08f8c6e3f84afbce0c23b66320cd2a8f2/doc/packer.txt#L199) en `$LUNARVIM_RUNTIME_DIR/site/pack/packer`.

Digamos que es `nvim-cmp` por ejemplo

```vim
:! git -C "$LUNARVIM_RUNTIME_DIR/site/pack/packer/start/nvim-cmp" status
```

ahora comprueba qué commit está verificado

```vim
:! git -C "$LUNARVIM_RUNTIME_DIR/site/pack/packer/start/nvim-cmp" log -1
```

esto debería coincidir con la que se encuentra en `$LUNARVIM_RUNTIME_DIR/lvim/snapshots/default.json`, aun así  siempre puedes restaurar la instantánea con `:LvimSyncCorePlugins`.

```vim
:! git -C "$LUNARVIM_RUNTIME_DIR/site/pack/packer/start/nvim-cmp" pull --rebase
```

### Fallo del Packer

si no has realizado ningún cambio en ninguno de los plugins, entonces puede eliminar la raíz del paquete de Packer por completo.

```shell
LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-$HOME/.local/share/lunarvim}"
rm -rf "$LUNARVIM_RUNTIME_DIR/site/pack/packer"
```

ahora abre el `lvim`, verás un montón de errores sobre todos los plugins que faltan, pero al ejecutar `:LvimSyncCorePlugins` debería arreglarlos todos.

## LunarVim ¡es lento!

### estas usando `fish`?

> En primer lugar, no se recomienda establecer el shell con fish en vim. Un montón de complementos de vim ejecutan shellscript incompatibles con fish, por lo que establecerlo con /bin/sh es mejor, especialmente si no tienes ninguna buena razón para establecerlo con fish.

```lua
vim.opt.shell = "/bin/sh"
```

Consulte [fish-shell/fish-shell#7004](https://github.com/fish-shell/fish-shell/issues/7004) y `:h 'shell'` para más información.

## ¡El servidor de lenguaje XXX no se inicia para mí!

### Actualice node

Algunos servidores de lenguaje dependen de versiones más recientes de node. Actualiza tu versión de node a la más reciente.

### ¿Se anula?

Esto podría deberse a que el servidor está [anulado](../languages/README.md#server-override)

```lua
--- is it in this list?
:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))
```

Si ese es el caso, entonces tienes que eliminarlo de la lista y volver a ejecutar`:LvimCacheReset`

```lua
vim.tbl_map(function(server)
  return server ~= "emmet_ls"
end, lvim.lsp.automatic_configuration.skipped_servers)
```

o configurarlo [manualmente](../languages/README.md#server-setup).

### ¿ Está soportado por [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer)?

Cualquier servidor que no aparezca en `LspInstallInfo` debe ser instalado manualmente.

### ¿Aparece al menos en `:LspInfo`?

ver los consejos para [depurar nvim-lspconfig](https://github.com/neovim/nvim-lspconfig#debugging).

## Demasiados servidores de lenguaje se están iniciando a a la vez.

¿Esta alguno de estos servidores [anulado](../languages/README.md#server-override) por defecto?

```lua
:lua print(vim.inspect(require("lvim.lsp.config").override))
```

Si lo esta, entonces está utilizando la sintaxis anterior a [LunarVim#1813](https://github.com/LunarVim/LunarVim/pull/1813).

```lua
-- this is the correct syntax since 3dd60bd
vim.list_extend(lvim.lsp.override, { "jsonls" })
```

```lua
-- this the correct syntax since 198577a
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jsonls" })
```

## ¡Mi LunarVim se ve horrible!

- Asegúrate de que tienes un terminal que soporta colores de 24 bits. Si no es así, es posible que tenga problemas con el esquema de colores por defecto y otros esquemas de colores.

  - Para una explicación de lo que son los colores de 24 bits, y para probar si tu terminal lo soporta, nos gusta usar este repositorio: https://github.com/termstandard/colors

- Otro problema puede ser el de los `termguicolores`. Si este es el caso, le aconsejamos que consulte la documentación oficial de neovim:

  - ¿Que es él `termguicolors`? consultar <https://neovim.io/doc/user/options.html#'termguicolors'>

- Otro caso puede ser que tu variable `$TERM` cambie los colores de tu terminal.
  - Para ello, te aconsejamos que mires si alguien más tiene la misma variable `$TERM` que tú https://github.com/neovim/neovim/issues?q=label%3Atui+color
