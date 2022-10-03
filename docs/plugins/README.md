# Plugins

Plugins are managed by [Packer](https://github.com/wbthomason/packer.nvim), and are split into [core-plugins](./01-core-plugins-list.md) and user-plugins.

- from [lua/lvim/plugin-loader.lua](https://github.com/lunarvim/lunarvim/blob/10c7753d8e6f572974f9b9e0d0d8631cd13e60ea/lua/lvim/plugin-loader.lua):

```lua
--- to check the full configuration `:lua print(vim.inspect(require('packer').config))`
local compile_path = join_paths(get_config_dir(), "plugin", "packer_compiled.lua")
local snapshot_path = join_paths(get_cache_dir(), "snapshots")
local package_root = join_paths(vim.fn.stdpath("data"), "site", "pack")

local init_opts = {
  package_root = package_root,
  compile_path = compile_path,
  snapshot_path = snapshot_path,
  log = { level = "warn" },
  git = {
    clone_timeout = 300,
  },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

packer.init(init_opts)
```

::: tip
use `:PackerStatus` to see a list of all installed plugins!
:::

## Core plugins

The configurations for core plugins are accessible through `lvim.builtin`. Most should contain an `active` attribute that can be set to `false` to disable the plugin

```lua
lvim.builtin.alpha.active = true
lvim.builtin.dap.active = true -- (default: false)
lvim.builtin.terminal.active = true
```
::: warning IMPORTANT
disabling a plugin will not take effect until you run `:PackerSync` or preferably `:LvimSyncCorePlugins`
:::

You can press `<TAB>` to get autocomplete suggestions to explore these settings.

```lua
lvim.builtin.cmp.completion.keyword_length = 2
lvim.builtin.telescope.defaults.layout_config.width = 0.95
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75
```

::: tip
A plugin's README (and `docs/` folder if it exists) typically contain excellent documentation, so it may be worthwhile to create an alias for if you use them often.
:::

### Pinning strategy

Snapshot support has been added in [lunarvim#2351](https://github.com/LunarVim/LunarVim/pull/2351):

> 1. add a default snapshot, `snapshots/default.json`, to hold the commits of all the core plugins
> 2. `LvimSyncCorePlugins` now uses `:PackerSnapshotRollback`
> 3. reduce errors caused by breaking changes in user plugins since they're not handled anymore with `packer.sync()`
> 4. `PackerSync` will now ignore all the core plugins which are already handled with snapshots, this makes it significantly faster to finish.
> 5. allow "unlocking" all the core plugins, by setting an environment variable `$LVIM_DEV_MODE`, e.g. can be defined in `~/.local/bin/lvim`
> 6. `$LUNARVIM_CACHE_DIR/snapshots/` can be used to store complete snapshots of _all_ the installed plugins, `:h packer.snapshot()`.
> 7. add a new handler to allow updating `snapshots/default.json` that does not rely on packer or lvim's runtime. It could be completely re-written in any other language.

## User plugins

User plugins can be installed by adding entries to the `lvim.plugins` table in your `config.lua` file, and saving or manually invoking `LvimReload` will trigger Packer to sync all the plugins in that table.

```lua
lvim.plugins = {
  {"lunarvim/colorschemes"},
  {"folke/tokyonight.nvim"},
}
```
Check the [extra plugins](./02-extra-plugins.md) for some suggestions.

_Note: removing a plugin from the `lvim.plugin` table removes it from your configuration but not your system. Any plugins left in the `start` directory will still autostart. To remove them completely, run `:PackerSync`._
