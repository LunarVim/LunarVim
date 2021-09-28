local M = {}

---Join path segments that were passed as input
---@return string
function _G.join_paths(...)
  local uv = vim.loop
  local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

---Get the full path to `$LUNARVIM_RUNTIME_DIR`
---@return string
function _G.get_runtime_dir()
  local lvim_runtime_dir = os.getenv "LUNARVIM_RUNTIME_DIR"
  if not lvim_runtime_dir then
    -- when nvim is used directly
    return vim.fn.stdpath "config"
  end
  return lvim_runtime_dir
end

---Get the full path to `$LUNARVIM_CONFIG_DIR`
---@return string
function _G.get_config_dir()
  local lvim_config_dir = os.getenv "LUNARVIM_CONFIG_DIR"
  if not lvim_config_dir then
    return vim.fn.stdpath "config"
  end
  return lvim_config_dir
end

---Get the full path to `$LUNARVIM_CACHE_DIR`
---@return string
function _G.get_cache_dir()
  local lvim_cache_dir = os.getenv "LUNARVIM_CACHE_DIR"
  if not lvim_cache_dir then
    return vim.fn.stdpath "cache"
  end
  return lvim_cache_dir
end

---Get currently installed version of LunarVim
---@param type string can be "short"
---@return string
function _G.get_version(type)
  type = type or ""
  local lvim_full_ver = vim.fn.system("git -C " .. get_runtime_dir() .. "/lvim describe --tags")

  if string.match(lvim_full_ver, "%d") == nil then
    return nil
  end
  if type == "short" then
    return vim.fn.split(lvim_full_ver, "-")[1]
  else
    return string.sub(lvim_full_ver, 1, #lvim_full_ver - 1)
  end
end

---Initialize the `&runtimepath` variables and prepare for startup
---@return table
function M:init()
  self.runtime_dir = get_runtime_dir()
  self.config_dir = get_config_dir()
  self.cache_path = get_cache_dir()
  self.repo_dir = join_paths(self.runtime_dir, "lvim")

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

---Update LunarVim
---pulls the latest changes from github and, resets the startup cache
function M:update()
  M:update_repo()
  M:reset_cache()
  vim.schedule(function()
    -- TODO: add a changelog
    vim.notify("Update complete", vim.log.levels.INFO)
  end)
end

local function git_cmd(subcmd)
  local Job = require "plenary.job"
  local Log = require "core.log"
  local repo_dir = join_paths(get_runtime_dir(), "lvim")
  local args = { "-C", repo_dir }
  vim.list_extend(args, subcmd)

  local stderr = {}
  local stdout, ret = Job
    :new({
      command = "git",
      args = args,
      cwd = repo_dir,
      on_stderr = function(_, data)
        table.insert(stderr, data)
      end,
    })
    :sync()

  if not vim.tbl_isempty(stderr) then
    Log:debug(stderr)
  end

  if not vim.tbl_isempty(stdout) then
    Log:debug(stdout)
  end

  return ret
end

---pulls the latest changes from github
function M:update_repo()
  local Log = require "core.log"
  local sub_commands = {
    fetch = { "fetch" },
    diff = { "diff", "--quiet", "@{upstream}" },
    merge = { "merge", "--ff-only", "--progress" },
  }
  Log:info "Checking for updates"

  local ret = git_cmd(sub_commands.fetch)
  if ret ~= 0 then
    error "Update failed! Check the log for further information"
  end

  ret = git_cmd(sub_commands.diff)

  if ret == 0 then
    Log:info "LunarVim is already up-to-date"
    return
  end

  ret = git_cmd(sub_commands.merge)

  if ret ~= 0 then
    error "Error: unable to guarantee data integrity while updating your branch"
    error "Please pull the changes manually instead."
  end
end

---Reset any startup cache files used by Packer and Impatient
---Tip: Useful for clearing any outdated settings
function M:reset_cache()
  _G.__luacache.clear_cache()
  _G.__luacache.save_cache()
  require("plugin-loader"):cache_reset()
end

return M
