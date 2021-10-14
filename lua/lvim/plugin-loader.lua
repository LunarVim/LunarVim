local plugin_loader = {}

local utils = require "lvim.utils"
local Log = require "lvim.core.log"
-- we need to reuse this outside of init()
local compile_path = get_config_dir() .. "/plugin/packer_compiled.lua"

local _, packer = pcall(require, "packer")

function plugin_loader.init(opts)
  opts = opts or {}

  local install_path = opts.install_path or vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
  local package_root = opts.package_root or vim.fn.stdpath "data" .. "/site/pack"

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    vim.cmd "packadd packer.nvim"
  end

  packer.init {
    package_root = package_root,
    compile_path = compile_path,
    git = { clone_timeout = 300 },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }
end

function plugin_loader.cache_clear()
  if vim.fn.delete(compile_path) == 0 then
    Log:debug "deleted packer_compiled.lua"
  end
end

function plugin_loader.recompile()
  plugin_loader.cache_clear()
  plugin_loader.compile()
  if utils.is_file(compile_path) then
    Log:debug "generated packer_compiled.lua"
  end
end

function plugin_loader.load(configurations)
  Log:debug "loading plugins configuration"
  packer.startup(function(use)
    for _, plugins in ipairs(configurations) do
      for _, plugin in ipairs(plugins) do
        use(plugin)
      end
    end
  end)
end

function plugin_loader.get_core_plugins()
  local list = {}
  local plugins = require "lvim.plugins"
  for _, item in pairs(plugins) do
    table.insert(list, item[1]:match "/(%S*)")
  end
  return list
end

function plugin_loader.sync_core_plugins()
  local core_plugins = plugin_loader.get_core_plugins()
  vim.cmd("PackerSync " .. unpack(core_plugins))
end

function plugin_loader.install()
  Log:debug "installing any missing plugins"
  local status_ok, _ = xpcall(packer.install(), debug.traceback)
  if not status_ok then
    Log:warn(debug.traceback())
  end
end

function plugin_loader.compile()
  Log:debug "compiling lazy_loaded plugins"
  local status_ok, _ = xpcall(packer.compile(), debug.traceback)
  if not status_ok then
    Log:warn(debug.traceback())
  end
end

function plugin_loader.update()
  Log:debug "updating any missing plugins"
  local status_ok, _ = xpcall(packer.compile(), debug.traceback)
  if not status_ok then
    Log:warn(debug.traceback())
  end
end

function plugin_loader.sync()
  Log:debug "syncing any missing plugins"
  local status_ok, _ = xpcall(packer.sync(), debug.traceback)
  if not status_ok then
    Log:warn(debug.traceback())
  end
end

return plugin_loader
