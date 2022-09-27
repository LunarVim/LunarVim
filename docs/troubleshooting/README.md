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

## Getting errors after an update

### Cache issues

This might be the result of old cache files that need to be reset. LunarVim makes use of  [impatients's](https://github.com/lewis6991/impatient.nvim) to optimize the startup procedure and deliver a snappy experience.

1. while running LunarVim: `:LvimCacheReset`
2. from the CLI: `lvim +LvimCacheReset`

### Plugin issue

Another common reason for such errors is due to Packer being unable to fully restore a snapshot. This could be due to multiple reasons, but mostl commonly it's a breaking change in some plugin, or `git` refusing to pull an update to a plugin because it [can't safely fast-forward the current branch](https://blog.sffc.xyz/post/185195398930/why-you-should-use-git-pull-ff-only-git-is-a).

The easiest way to solve this is to manually update (a rebase is likely required) the offending plugin, which should be located in [Packer's package-root](https://github.com/wbthomason/packer.nvim/blob/4dedd3b08f8c6e3f84afbce0c23b66320cd2a8f2/doc/packer.txt#L199) at `$LUNARVIM_RUNTIME_DIR/site/pack/packer`. 

Let's say it's `nvim-cmp` for example

```vim
:! git -C "$LUNARVIM_RUNTIME_DIR/site/pack/packer/start/nvim-cmp" status
```

now check which commit is currently checked out
```vim
:! git -C "$LUNARVIM_RUNTIME_DIR/site/pack/packer/start/nvim-cmp" log -1
```

it should match the one in `$LUNARVIM_RUNTIME_DIR/lvim/snapshots/default.json`, but you can always restore the snapshot with `:LvimSyncCorePlugins`

```vim
:! git -C "$LUNARVIM_RUNTIME_DIR/site/pack/packer/start/nvim-cmp" pull --rebase
```

### Packer failure

if you have not done any changes to any of the plugins, then you can remove Packer's package root completely.

```shell
LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-$HOME/.local/share/lunarvim}"
rm -rf "$LUNARVIM_RUNTIME_DIR/site/pack/packer"
```

now open `lvim`, you'll see a lot of errors about all the plugins missing, but running `:LvimSyncCorePlugins` should fix them all.

## LunarVim is slow!

### are you using `fish`?

> First of all, it is not recommended to set shell to fish in vim. Plenty of vim addons execute fish-incompatible shellscript, so setting it to /bin/sh is typically better, especially if you have no good reason to set it to fish.

```lua
vim.opt.shell = "/bin/sh"
```

See [fish-shell/fish-shell#7004](https://github.com/fish-shell/fish-shell/issues/7004) and `:h 'shell'` for more info.

## Language server XXX does not start for me!

### Update node

Some language servers depend on newer versions of node.  Update your version of node to the latest.

### is it overriden?

This could be due to the fact that the server is [overridden](../languages/README.md#server-override)

```lua
--- is it in this list?
:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))
```

If that's the case, then you need to either remove it from that list and re-run `:LvimCacheReset`

```lua
vim.tbl_map(function(server)
  return server ~= "emmet_ls"
end, lvim.lsp.automatic_configuration.skipped_servers)
```

or set it up [manually](../languages/README.md#server-setup).

### is it supported by [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer)?

Any server that does not show up in `LspInstallInfo` needs to be installed manually.

### is it at least showing up in `:LspInfo`?

Check out the tips for [debugging nvim-lspconfig](https://github.com/neovim/nvim-lspconfig#debugging).

## Too many language servers are starting at once!

Are any of these servers [overridden](../languages/README.md#server-override) by default?

```lua
:lua print(vim.inspect(require("lvim.lsp.config").override))
```

If they are then you are using the syntax prior to [LunarVim#1813](https://github.com/LunarVim/LunarVim/pull/1813).

```lua
-- this is the correct syntax since 3dd60bd
vim.list_extend(lvim.lsp.override, { "jsonls" })
```

```lua
-- this the correct syntax since 198577a
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jsonls" })
```


## My LunarVim looks ugly!

- Make sure that you have a terminal that supports 24-bit colors. If not, you might face some issues regarding the default colorscheme, and other colorschemes. 
  - For a explainer on what 24-bit colors are, and to test if your terminal supports it, we like this usefull repository: https://github.com/termstandard/colors

- Another issue might be `termguicolors`. If this is the case, we advice you to look at the official neovim docs:
  - What is `termguicolors`? see <https://neovim.io/doc/user/options.html#'termguicolors'>

- Another case might be that your `$TERM` variable changes the colors in your terminal.
  - For this, we advice you to look and see if anyone else has the same `$TERM` variable as you, and what they did https://github.com/neovim/neovim/issues?q=label%3Atui+color

