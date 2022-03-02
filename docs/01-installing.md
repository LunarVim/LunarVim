# Installation

## Prerequisites

- Make sure you have installed the latest version of [`Neovim 0.5`](https://github.com/neovim/neovim/releases/tag/v0.6.1).
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
## Tips for WSL 2 users

While using LunarVim within WSL2, there are a few things one should be aware off:
1. Avoid using LunarVm within the Windows directory, e.g. `/mnt/c`, due to filesystem performance issues, see [WSL#4197](https://github.com/microsoft/WSL/issues/4197).
2. Some WSL2 users have experienced that sourcing the clipboard may be slow. A workaround for that is calling a clipboard manager from the Windows side. Neovim tries using [win32yank.exe](https://github.com/equalsraf/win32yank) if it's available. so install it and set the value of `clipboard` explicitly:
```lua
if vim.fn.has "wsl" == 1 then
  vim.g.clipboard = {
    copy = {
      ["+"] = "win32yank.exe -i --crlf", 
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
  }
end

```

## Uninstall

You can remove LunarVim (including the configuration files) using the bundled `uninstall` script

```bash
bash ~/.local/share/lunarvim/lvim/utils/installer/uninstall.sh
# or
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
```


