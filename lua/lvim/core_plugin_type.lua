local a = require "packer.async"
local log = require "packer.log"
local util = require "packer.util"
local result = require "packer.result"

local async = a.sync
local await = a.wait

local symlink_fn
if util.is_windows then
  symlink_fn = function(path, new_path, flags, callback)
    flags = flags or {}
    flags.junction = true
    return vim.loop.fs_symlink(path, new_path, flags, callback)
  end
else
  symlink_fn = vim.loop.fs_symlink
end

local symlink = a.wrap(symlink_fn)

local function setup_local(plugin)
  local bootstrap = require "lvim.bootstrap"
  local commit = plugin.commit
  local repo = plugin[1]
  local name = repo:match "/(%S*)"
  plugin.url = "https://github.com/" .. repo

  plugin.installer = function(disp)
    local from = join_paths(bootstrap.core_install_dir, name .. "-" .. commit)
    local to = plugin.install_path

    return async(function()
      disp:task_update(plugin[1], "making symlink...")
      local err, success = await(symlink(from, to, { dir = true }))
      if not success then
        plugin.output = { err = { err } }
        return result.err(err)
      end
      return result.ok()
    end)
  end

  plugin.updater = function(_)
    return async(function()
      return result.ok()
    end)
  end
  plugin.revert_last = function(_)
    log.warn "Can't revert a core plugin!"
    return result.ok()
  end
end

return { setup = setup_local }
