# Installation

## Prerequisites

- Make sure you have installed the latest version of [`Neovim 0.5`](https://github.com/neovim/neovim/releases/tag/v0.5.0).
- Have `npm`, `node` and `cargo` installed on your system.
- [Resolve `EACCES` permissions when installing packages globally](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally) to avoid error when installing packages with npm.

# Install

There are a few ways to install LunarVim.

## Stable

No alarm or surprise:

```bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

## Rolling

All the new features with all the new bugs:

```bash
LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
```

You can use this helper script to get the latest neovim binary as well:

```bash
bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
```

Make sure to check the [troubleshooting](./troubleshooting/README.md) section if you encounter any problem.

## Tips for users in Mainland China

Connection issues may cause installation failures. To avoid them when downloading content from GitHub, please use a mirror.

For example, [GitHub Proxy Mirror](https://mirror.ghproxy.com/) is a fast mirror for accessing github content. Add the following lines to `/etc/hosts` to accelerate your installation.

```
mirror.ghproxy.com github.com
mirror.ghproxy.com raw.githubusercontent.com
```

## Uninstall

You can remove LunarVim entirely by running the following commands:

```bash
rm -rf ~/.local/share/lunarvim

sudo rm /usr/local/bin/lvim

rm ~/.local/bin/lvim

rm -rf ~/.local/share/applications/lvim.desktop
```

If reinstalling, also remove the packer_compiled folder

```bash
 rm -rf ~/.config/lvim/plugin
```
