local M = {}
-- It's not safe to require 'utils' without adjusting the runtimepath
function _G.join_paths(...)
  local uv = vim.loop
  local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

function _G.get_runtime_dir()
  local lvim_runtime_dir = os.getenv "LUNARVIM_RUNTIME_DIR"
  if not lvim_runtime_dir then
    -- when nvim is used directly
    return vim.fn.stdpath "config"
  end
  return lvim_runtime_dir
end

function _G.get_config_dir()
  local lvim_config_dir = os.getenv "LUNARVIM_CONFIG_DIR"
  if not lvim_config_dir then
    return vim.fn.stdpath "config"
  end
  return lvim_config_dir
end

function _G.get_cache_dir()
  local lvim_cache_dir = os.getenv "LUNARVIM_CACHE_DIR"
  if not lvim_cache_dir then
    return vim.fn.stdpath "cache"
  end
  return lvim_cache_dir
end

function _G.get_version(type)
  local lvim_full_ver = vim.fn.system("git -C " .. get_runtime_dir() .. "/lvim describe --tag")
  if type == "short" then
    return vim.fn.split(lvim_full_ver, "-")[1]
  else
    return string.sub(lvim_full_ver, 1, #lvim_full_ver - 1)
  end
end

function M:init()
  self.runtime_dir = get_runtime_dir()
  self.config_dir = get_config_dir()
  self.cache_path = get_cache_dir()

  self.pack_dir = join_paths(self.runtime_dir, "site", "pack")
  self.packer_install_dir = join_paths(self.runtime_dir, "site", "pack", "packer", "start", "packer.nvim")
  self.packer_cache_path = join_paths(self.config_dir, "plugin", "packer_compiled.lua")

  if os.getenv "LUNARVIM_RUNTIME_DIR" then
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath "data", "site"))
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath "data", "site", "after"))
    vim.opt.rtp:prepend(join_paths(self.runtime_dir, "site"))
    vim.opt.rtp:append(join_paths(self.runtime_dir, "site", "after"))

    vim.opt.rtp:remove(vim.fn.stdpath "config")
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath "config", "after"))
    vim.opt.rtp:prepend(self.config_dir)
    vim.opt.rtp:append(join_paths(self.config_dir, "after"))
    -- TODO: we need something like this: vim.opt.packpath = vim.opt.rtp

    vim.cmd [[let &packpath = &runtimepath]]
    vim.cmd("set spellfile=" .. join_paths(self.config_dir, "spell", "en.utf-8.add"))
  end

  -- FIXME: currently unreliable in unit-tests
  if not os.getenv "LVIM_TEST_ENV" then
    vim.fn.mkdir(vim.fn.stdpath "cache", "p")
    require("impatient").setup {
      path = vim.fn.stdpath "cache" .. "/lvim_cache",
      enable_profiling = true,
    }
  end

  local config = require "config"
  config:init {
    path = join_paths(self.config_dir, "config.lua"),
  }

  require("plugin-loader"):init {
    package_root = self.pack_dir,
    install_path = self.packer_install_dir,
  }

  return self
end

return M
