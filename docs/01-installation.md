# Installation

## Prerequisites

- Make sure you have installed the latest version of [`Neovim v0.8.0+`](https://github.com/neovim/neovim/releases/latest).
- Have `git`, `make`, `pip`, `npm`, `node` and `cargo` installed on your system.
- [Resolve `EACCES` permissions when installing packages globally](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally) to avoid error when installing packages with npm.

## Release

(Neovim 0.8.0)

No alarms and No surprises:

```bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

## Nightly

(Neovim 0.9.0)

All the new features with all the new bugs:

```bash
LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
```

Make sure to check the [troubleshooting](./troubleshooting/README.md) section if you encounter any problem.
<iframe width="560" height="315" src="https://www.youtube.com/embed/NlRxRtGpHHk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="1"></iframe>

## Updating LunarVim

- Inside LunarVim `:LvimUpdate`
- From the command-line `lvim +LvimUpdate +q`

### Update the plugins

- Inside LunarVim `:LvimSyncPlugins`

## Uninstall

You can remove LunarVim (including the configuration files) using the bundled `uninstall` script

```bash
bash ~/.local/share/lunarvim/lvim/utils/installer/uninstall.sh
# or
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
```
