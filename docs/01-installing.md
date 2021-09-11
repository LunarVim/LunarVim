# Prerequisites

* There were some breaking changes in the development. To rule out incompatibilities make sure you have installed the latest version of [``Noevim 0.5``](https://github.com/neovim/neovim/releases/tag/v0.5.0).
* Have `npm` and `node` installed on your system
* [Resolve `EACCES` permissions when installing packages globally](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally) to avoid error when installing packages with npm

# Install

There are a few ways to install LunarVim

## Stable

No alarms and no surprises:

```bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

## Rolling

All the new features with all the new bugs:

```bash
LVBRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
```

```bash
bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
```

## After installation

* Add lvim to `PATH`. LunarVim should installed to `~/.local/bin/` so add this to your shell configuration file (`.bashrc`, `.zshrc` etc.):

    ```bash
    export PATH="$HOME/.local/bin/:$PATH"
    ```

* Run lvim and then `:PackerInstall`
* Make sure your plugins are installed and updated. Run `:PackerSync`
* Restart lvim

## Troubleshooting installation problems

If you encounter problems with the installation check the following:

1. If you get `EACCES` during the install,:

    ```bash
    npm ERR! code EACCES
    npm ERR! syscall mkdir
    npm ERR! path /usr/lib/node_modules/neovim
    npm ERR! errno -13
    npm ERR! Error: EACCES: permission denied, mkdir '/usr/lib/node_modules/neovim'
    npm ERR!  [Error: EACCES: permission denied, mkdir '/usr/lib/node_modules/neovim'] {
    npm ERR!   errno: -13,
    npm ERR!   code: 'EACCES',
    npm ERR!   syscall: 'mkdir',
    npm ERR!   path: '/usr/lib/node_modules/neovim'
    npm ERR! }
    ```

    follow npm's [suggested fix](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally)
2. Make sure neovim was compiled with luajit. The output of version information `nvim -v` should include a line for: `LuaJIT`.
3. Make sure all the dependencies listed in [Manual Install](#manual-install) are actually installed on your system.
4. If you're upgrading your install, sometimes an old packer compiled file can cause errors at runtime. Remove the folder. `rm -rf ~/.config/lvim/plugin` and run `:PackerSync`
5. If you're upgrading from an older version of LunarVim, remove the old launcher. `sudo rm /usr/local/bin/lvim`

## Uninstall

You can remove LunarVim entirely by running the following commands:

```bash
rm -rf ~/.local/share/lunarvim

sudo rm /usr/local/bin/lvim

rm ~/.local/bin/lvim

rm -rf ~/.local/share/applications/lvim.desktop
```
