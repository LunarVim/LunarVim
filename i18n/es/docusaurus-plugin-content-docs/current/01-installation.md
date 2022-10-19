# Instalación

## Requisitos Previos

- Asegúrate de tener instalado la última versión de [`Neovim v0.8.0+`](https://github.com/neovim/neovim/releases/latest).
- Debes tener `git`, `make`, `pip`, `npm`, `node` y `cargo` instalados en tu sistema.
- [Resolver permisos `EACCES` al instalar paquetes globalmente](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally) para evitar errores al instalar paquetes con npm.

## Ultima Versión Estable

(Neovim 0.8.0)

Sin alarmas y sin sorpresas:

```bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

## Nightly

(Neovim 0.9.0)

Todas las nuevas características con todos los nuevos errores:

```bash
LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
```

Asegúrate de comprobar la sección de [troubleshooting](./troubleshooting/) si te encuentras con algún problema.

<iframe width="560" height="315" src="https://www.youtube.com/embed/NlRxRtGpHHk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="1"></iframe>

## Actualizar LunarVim

- Dentro de LunarVim `:LvimUpdate`
- Desde la consola de comandos `lvim +LvimUpdate +q`

### Actualizar los plugins

- Dentro de LunarVim `:LvimSyncPlugins`

## Desinstalar

Puedes eliminar LunarVim (incluyendo los archivos de configuración) utilizando el script `uninstall`

```bash
bash ~/.local/share/lunarvim/lvim/utils/installer/uninstall.sh
# o
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
```
