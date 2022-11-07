# Installation

## Prerequisites

- Make sure you have installed the latest version of [`Neovim v0.8.0+`](https://github.com/neovim/neovim/releases/latest).
- Have `git`, `make`, `pip`, `npm`, `node` and `cargo` installed on your system.
- [Resolve `EACCES` permissions when installing packages globally](https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally) to avoid error when installing packages with npm.
- [`PowerShell 7+`](https://learn.microsoft.com/en-us/powershell/scripting/whats-new/migrating-from-windows-powershell-51-to-powershell-7?view=powershell-7.2) (for Windows)

## Release

(Neovim 0.8.0)

No alarms and No surprises:

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
<TabItem value="linux/macos" label="Linux/MacOs">

```bash
LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

</TabItem>
<TabItem value="windows" label="Windows">

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/LunarVim/LunarVim/master/utils/installer/install.ps1 -UseBasicParsing | Invoke-Expression
```

</TabItem>
</Tabs>

## Nightly

(Neovim 0.9.0)

All the new features with all the new bugs:

```bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

Make sure to check the [troubleshooting](./troubleshooting/README.md) section if you encounter any problem.
<iframe width="560" height="315" src="https://www.youtube.com/embed/NlRxRtGpHHk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="1"></iframe>

## Updating LunarVim

- Inside LunarVim `:LvimUpdate`
- From the command-line `lvim +LvimUpdate +q`

### Update the plugins

- Inside LunarVim `:LvimSyncCorePlugins`

## Uninstall

You can remove LunarVim (including the configuration files) using the bundled `uninstall` script

```bash
bash ~/.local/share/lunarvim/lvim/utils/installer/uninstall.sh
# or
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
```
