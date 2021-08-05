# Install

There are a few ways to install LunarVim

## Stable

No alarms and no surprises:

```bash
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/master/utils/installer/install.sh)
```

## Rolling

All the new features with all the new bugs:

```bash
LVBRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/rolling/utils/installer/install.sh)
```

Make sure you have the newest version of Neovim (0.5).

``` bash
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/LunarVim/rolling/utils/bin/install-latest-neovim)
```

After installation run `lvim` and then `:PackerInstall`

## Troubleshooting installation problems
If you encounter problems with the installation check the following: 
1. Make sure you have at least version 0.5 of neovim. There were some breaking changes in the development of 0.5 so upgrade to the newest available version to rule out incompatibilities.  
1. Make sure neovim was compiled with luajit. 
  ```bash
  # The output of version information should include a line for: LuaJIT 
  nvim -v
  ```
1. Make sure all the dependencies listed in [Manual Install](#manual-install) are actually installed on your system.
1. Make sure your plugins are installed and updated. Run `:PackerSync`
1. If you're upgrading your install, sometimes an old packer compiled file can cause errors at runtime.  Remove the folder.  `rm -rf ~/.config/lvim/plugin` and run `:PackerSync`

## Uninstall

You can remove LunarVim entirely by running the following commands: 

```bash
rm -rf ~/.local/share/lunarvim

sudo rm /usr/local/bin/lvim

rm -rf ~/.local/share/applications/lvim.desktop
```


