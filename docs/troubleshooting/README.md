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

### is it overriden?

This could be due to the fact that the server is [overridden](../languages/README.md#manually-configured-servers)

```lua
--- is it in this list?
:lua print(vim.inspect(lvim.lsp.override))
```

If that's the case, then you need to either remove it from that list and re-run `:LvimCacheReset` or set it up [manually](../languages/README.md#overriding-the-default-setup-options).

### is it supported by [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer)?

Any server that does not show up in `LspInstallInfo` needs to be installed manually.

### is it at least showing up in `:LspInfo`?

Check out the tips for [debugging nvim-lspconfig](https://github.com/neovim/nvim-lspconfig#debugging).

## Too many language servers are starting at once!

Are any of these servers [overridden](../languages/README.md#manually-configured-servers) by default?

```lua
:lua print(vim.inspect(require("lvim.lsp.config").override))
```

If they are then you are using the syntax prior to [LunarVim#1813](https://github.com/LunarVim/LunarVim/pull/1813).

```lua
-- this is the correct syntax since 3dd60bd
vim.list_extend(lvim.lsp.override, { "jsonls" })
```
