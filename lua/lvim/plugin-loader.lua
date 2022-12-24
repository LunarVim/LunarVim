local plugin_loader = {}

local utils = require "lvim.utils"
local Log = require "lvim.core.log"
local join_paths = utils.join_paths

local plugins_dir = join_paths(get_runtime_dir(), "lazy", "plugins")

function plugin_loader.init(opts)
  opts = opts or {}

  local lazy_install_dir = opts.install_path or join_paths(vim.fn.stdpath "data", "lazy", "plugins", "lazy.nvim")

  if not utils.is_directory(lazy_install_dir) then
    print "Initializing first time setup"
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "https://github.com/folke/lazy.nvim.git",
      lazy_install_dir,
    }
  end

  vim.opt.runtimepath:prepend(lazy_install_dir)

  -- Add plugins to rtp (needed for config:init)
  -- TODO: is there a better way to do this?
  require("lazy.core.util").ls(plugins_dir, function(path, name, type)
    if type == "directory" and name ~= "lazy.nvim" then
      vim.opt.rtp:append(path)
    end
  end)
end

function plugin_loader.reset_cache()
  os.remove(require("lazy.core.cache").config.path)
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

  -- Close lazy.nvim after installing plugins the first time
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      if vim.opt.ft:get() == "lazy" then
        require("lazy.view"):close()
        vim.cmd "q"
      end
    end,
  })

  local status_ok = xpcall(function()
    local opts = {
      install = {
        missing = true,
        colorscheme = { lvim.colorscheme, "lunar", "habamax" },
      },
      root = plugins_dir,
      git = {
        timeout = 120,
      },
      lockfile = join_paths(get_config_dir(), "lazy-lock.json"),
      performance = {
        cache = {
          enabled = true,
          path = join_paths(get_cache_dir(), "lazy", "cache"),
        },
        rtp = {
          reset = false,
        },
      },
      readme = {
        root = join_paths(get_runtime_dir(), "lazy", "readme"),
      },
      display = {
        open_fn = function()
          return require("packer.util").float { border = "rounded" }
        end,
      },
    }

    lazy.setup(configurations, opts)
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

function plugin_loader.load_snapshot(snapshot_file)
  error "plugin pinning not implemented"
end

function plugin_loader.sync_core_plugins()
  local core_plugins = plugin_loader.get_core_plugins()
  Log:trace(string.format("Syncing core plugins: [%q]", table.concat(core_plugins, ", ")))
  require("lazy").sync { wait = true, plugins = core_plugins }
end

function plugin_loader.ensure_plugins()
  Log:debug "calling lazy.install()"
  require("lazy").install { wait = true }
end

return plugin_loader
