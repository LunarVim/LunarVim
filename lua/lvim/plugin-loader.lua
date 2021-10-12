local plugin_loader = {}

local utils = require "lvim.utils"
local Log = require "lvim.core.log"
-- we need to reuse this outside of init()
local compile_path = get_config_dir() .. "/plugin/packer_compiled.lua"

function plugin_loader:init(opts)
  opts = opts or {}

  local install_path = opts.install_path or vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
  local package_root = opts.package_root or vim.fn.stdpath "data" .. "/site/pack"

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    vim.cmd "packadd packer.nvim"
  end

  local packer_ok, packer = pcall(require, "packer")
  if not packer_ok then
    return
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

  self.packer = packer
  return self
end

function plugin_loader:cache_clear()
  if vim.fn.delete(compile_path) == 0 then
    Log:debug "deleted packer_compiled.lua"
  end
end

function plugin_loader:cache_reset()
  plugin_loader:cache_clear()
  require("packer").compile()
  if utils.is_file(compile_path) then
    Log:debug "generated packer_compiled.lua"
  end
end

function plugin_loader:load(configurations)
  return self.packer.startup(function(use)
    for _, plugins in ipairs(configurations) do
      for _, plugin in ipairs(plugins) do
        use(plugin)
      end
    end
  end)
end

function plugin_loader:get_core_plugins()
  local list = {}
  local plugins = require "lvim.plugins"
  for _, item in pairs(plugins) do
    table.insert(list, item[1]:match "/(%S*)")
  end
  return list
end

function plugin_loader:sync_core_plugins()
  local core_plugins = plugin_loader.get_core_plugins()
  vim.cmd("PackerSync " .. unpack(core_plugins))
end

return plugin_loader
