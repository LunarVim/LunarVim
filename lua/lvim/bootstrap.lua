local M = {}

if vim.fn.has "nvim-0.9" ~= 1 then
  vim.notify("Please upgrade your Neovim base installation. Lunarvim requires v0.9+", vim.log.levels.WARN)
  vim.wait(5000, function()
    ---@diagnostic disable-next-line: redundant-return-value
    return false
  end)
  vim.cmd "cquit"
end

local uv = vim.loop
local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"

---Join path segments that were passed as input
---@return string
function _G.join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end

_G.require_clean = require("lvim.utils.modules").require_clean
_G.require_safe = require("lvim.utils.modules").require_safe
_G.reload = require("lvim.utils.modules").reload

---Get the full path to stdpath("data")
---@return string|nil
function _G.get_runtime_dir()
  return vim.call("stdpath", "data")
end

---Get the full path to stdpath("config")
---@return string|nil
function _G.get_config_dir()
  return vim.call("stdpath", "config")
end

---Get the full path to stdpath("cache")
---@return string|nil
function _G.get_cache_dir()
  return vim.call("stdpath", "cache")
end

---Initialize the `&runtimepath` variables and prepare for startup
---@return table
function M:init(base_dir)
  self.runtime_dir = get_runtime_dir()
  self.config_dir = get_config_dir()
  self.cache_dir = get_cache_dir()
  self.pack_dir = join_paths(self.runtime_dir, "site", "pack")
  self.lazy_install_dir = join_paths(self.pack_dir, "lazy", "opt", "lazy.nvim")

  ---Get the full path to LunarVim's base directory
  ---@return string
  function _G.get_lvim_base_dir()
    return base_dir
  end

  require("lvim.plugin-loader").init {
    package_root = self.pack_dir,
    install_path = self.lazy_install_dir,
  }

  require("lvim.config"):init()

  require("lvim.core.mason").bootstrap()

  return self
end

---Update LunarVim
---pulls the latest changes from github and, resets the startup cache
function M:update()
  require("lvim.core.log"):info "Trying to update LunarVim..."

  vim.schedule(function()
    reload("lvim.utils.hooks").run_pre_update()
    local ret = reload("lvim.utils.git").update_base_lvim()
    if ret then
      reload("lvim.utils.hooks").run_post_update()
    end
  end)
end

return M
