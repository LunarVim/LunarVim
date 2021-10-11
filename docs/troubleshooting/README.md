# Installation

## General

1. Make sure to check that you have a recent Neovim version with `luajit` support. The output of version information `nvim -v` should include a line for: `LuaJIT`.
2. Make sure all the dependencies listed in [Manual Install](#manual-install) are actually installed on your system.

## Unable to run `lvim`

Make sure that `lvim` is available and executable on your path. You can check the results of these commands to verify that

```shell
which lvim
stat "$(which lvim)"
cat "$(which lvim)"
```

If you get errors with any of the above commands, then you need to either fix that manually or reinstall the binary again.

```shell
cd <lunarvim-repo> # this will be in `~/.local/share/lunarvim/lvim` by default
bash utils/installer/install_bin.sh
```

## Getting a lot of errors when opening `lvim` after an update

This might be the result of old cache files that need to be reset. LunarVim makes use of those to optimize the startup procedure
and deliver a pleasant experience.

You can run `LvimCacheReset` to fix most of these issues.
1. while running LunarVim: `:LvimCacheReset`
2. from the CLI: `lvim +LvimCacheReset`

If that doesn't work, try re-syncing your plugins:
1. while running LunarVim: `:PackerSync`
2. from the CLI: `lvim +PackerSync`

## Language server XXX does not start for me!

Check out the tips for [debugging nvim-lspconfig](https://github.com/neovim/nvim-lspconfig#debugging).
