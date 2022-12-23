local plugin_loader = {}

local utils = require "lvim.utils"
local Log = require "lvim.core.log"
local join_paths = utils.join_paths

local plugins_dir = join_paths(get_runtime_dir(), "lazy", "plugins")

local function remove_rtp_paths()
  if os.getenv "LUNARVIM_RUNTIME_DIR" then
    vim.opt.rtp:remove(join_paths(vim.call("stdpath", "data"), "site"))
    vim.opt.rtp:remove(join_paths(vim.call("stdpath", "data"), "site", "after"))
    vim.opt.rtp:remove(vim.call("stdpath", "config"))
    vim.opt.rtp:remove(join_paths(vim.call("stdpath", "config"), "after"))
  end
end

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

  remove_rtp_paths()
  vim.opt.rtp:prepend(lazy_install_dir)

  -- Add plugins to rtp (needed for config:init)
  -- TODO: is there a better way to do this?
  local handle = vim.loop.fs_scandir(plugins_dir)
  if not handle then
    return
  end
  while true do
    local subdir, _ = vim.loop.fs_scandir_next(handle)
    if not subdir then
      break
    end
    subdir = join_paths(plugins_dir, subdir)

    local subdir_stats = vim.loop.fs_stat(subdir)

    if subdir_stats and subdir_stats.type == "directory" then
      vim.opt.rtp:append(subdir)
    end
  end
end

function plugin_loader.reload(configurations)
  -- _G.packer_plugins = _G.packer_plugins or {}
  -- for k, v in pairs(_G.packer_plugins) do
  --   if k ~= "packer.nvim" then
  --     _G.packer_plugins[v] = nil
  --   end
  -- end
  -- plugin_loader.load(configurations)

  -- plugin_loader.ensure_plugins()
end

function plugin_loader.load(configurations)
  Log:debug "loading plugins configuration"
  local lazy_available, lazy = pcall(require, "lazy")
  if not lazy_available then
    Log:warn "skipping loading plugins until lazy.nvim is installed"
    return
  end

  local status_ok = xpcall(function()
    local opts = {
      root = plugins_dir,
      git = {
        timeout = 120,
      },
      performance = {
        cache = {
          enabled = false,
          path = join_paths(get_cache_dir(), "lazy", "cache"),
        },
        rtp = {
          paths = {
            get_lvim_base_dir(),
            get_runtime_dir(),
            get_config_dir(),
          },
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

  remove_rtp_paths()

  if not status_ok then
    Log:warn "problems detected while loading plugins' configurations"
    Log:trace(debug.traceback())
  end
end

function plugin_loader.get_core_plugins()
  -- local list = {}
  -- local plugins = require "lvim.plugins"
  -- for _, item in pairs(plugins) do
  --   if item.enabled == true or item.enabled == nil then
  --     table.insert(list, item[1]:match "/(%S*)")
  --   end
  -- end
  -- return list
end

function plugin_loader.load_snapshot(snapshot_file)
  -- snapshot_file = snapshot_file or default_snapshot
  -- if not in_headless then
  --   vim.notify("Syncing core plugins is in progress..", vim.log.levels.INFO, { title = "lvim" })
  -- end
  -- Log:debug(string.format("Using snapshot file [%s]", snapshot_file))
  -- local core_plugins = plugin_loader.get_core_plugins()
  -- require("packer").rollback(snapshot_file, unpack(core_plugins))
end

function plugin_loader.sync_core_plugins()
  -- plugin_loader.cache_clear()
  -- local core_plugins = plugin_loader.get_core_plugins()
  -- Log:trace(string.format("Syncing core plugins: [%q]", table.concat(core_plugins, ", ")))
  -- pcall_packer_command("sync", core_plugins)
end

function plugin_loader.ensure_plugins()
  -- vim.api.nvim_create_autocmd("User", {
  --   pattern = "PackerComplete",
  --   once = true,
  --   callback = function()
  --     plugin_loader.compile()
  --   end,
  -- })
  -- Log:debug "calling packer.install()"
  -- pcall_packer_command "install"
end

return plugin_loader
