local plugin_loader = {}

local utils = require "lvim.utils"
local Log = require "lvim.core.log"
local join_paths = utils.join_paths

local plugins_dir = join_paths(get_runtime_dir(), "site", "pack", "lazy", "opt")

function plugin_loader.init(opts)
  opts = opts or {}

  local lazy_install_dir = opts.install_path
    or join_paths(vim.fn.stdpath "data", "site", "pack", "lazy", "opt", "lazy.nvim")

  if not utils.is_directory(lazy_install_dir) then
    print "Initializing first time setup"
    local core_plugins_dir = join_paths(get_lvim_base_dir(), "plugins")
    if utils.is_directory(core_plugins_dir) then
      vim.fn.mkdir(plugins_dir, "p")
      vim.fn.delete(plugins_dir, "rf")
      require("lvim.utils").fs_copy(core_plugins_dir, plugins_dir)
    else
      vim.fn.system {
        "git",
        "clone",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazy_install_dir,
      }

      local default_snapshot_path = join_paths(get_lvim_base_dir(), "snapshots", "default.json")
      local snapshot = assert(vim.fn.json_decode(vim.fn.readfile(default_snapshot_path)))
      vim.fn.system {
        "git",
        "-C",
        lazy_install_dir,
        "checkout",
        snapshot["lazy.nvim"].commit,
      }
    end

    vim.api.nvim_create_autocmd("User", { pattern = "LazyDone", callback = require("lvim.lsp").setup })
  end

  vim.opt.runtimepath:append(lazy_install_dir)
  vim.opt.runtimepath:append(join_paths(plugins_dir, "*"))

  pcall(function()
    -- set a custom path for lazy's cache
    local lazy_cache = require "lazy.core.cache"
    lazy_cache.path = join_paths(get_cache_dir(), "lazy", "luac")
  end)
end

function plugin_loader.reload(spec)
  local Config = require "lazy.core.config"
  local lazy = require "lazy"

  -- TODO: reset cache? and unload plugins?

  Config.spec = spec

  require("lazy.core.plugin").load(true)
  require("lazy.core.plugin").update_state()

  local not_installed_plugins = vim.tbl_filter(function(plugin)
    return not plugin._.installed
  end, Config.plugins)

  require("lazy.manage").clear()

  if #not_installed_plugins > 0 then
    lazy.install { wait = true }
  end

  if #Config.to_clean > 0 then
    -- TODO: set show to true when lazy shows something useful on clean
    lazy.clean { wait = true, show = false }
  end
end

function plugin_loader.load(configurations)
  Log:debug "loading plugins configuration"
  local lazy_available, lazy = pcall(require, "lazy")
  if not lazy_available then
    Log:warn "skipping loading plugins until lazy.nvim is installed"
    return
  end

  -- remove plugins from rtp before loading lazy, so that all plugins won't be loaded on startup
  vim.opt.runtimepath:remove(join_paths(plugins_dir, "*"))

  local status_ok = xpcall(function()
    table.insert(lvim.lazy.opts.install.colorscheme, 1, lvim.colorscheme)
    lazy.setup(configurations, lvim.lazy.opts)
  end, debug.traceback)

  if not status_ok then
    Log:warn "problems detected while loading plugins' configurations"
    Log:trace(debug.traceback())
  end
end

function plugin_loader.get_core_plugins()
  local names = {}
  local plugins = require "lvim.plugins"
  local get_name = require("lazy.core.plugin").Spec.get_name
  for _, spec in pairs(plugins) do
    if spec.enabled == true or spec.enabled == nil then
      table.insert(names, get_name(spec[1]))
    end
  end
  return names
end

function plugin_loader.sync_core_plugins()
  local core_plugins = plugin_loader.get_core_plugins()
  Log:trace(string.format("Syncing core plugins: [%q]", table.concat(core_plugins, ", ")))
  require("lazy").update { wait = true, plugins = core_plugins }
end

function plugin_loader.ensure_plugins()
  Log:debug "calling lazy.install()"
  require("lazy").install { wait = true }
end

return plugin_loader
