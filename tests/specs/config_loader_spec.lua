local a = require "plenary.async_lib.tests"
local config = require "lvim.config"
local utils = require "lvim.utils"

a.describe("config-loader", function()
  local user_config_path = config:get_user_config_path()

  a.it("should be able to find user-config", function()
    assert.equal(user_config_path, get_config_dir() .. "/config.lua")
  end)

  a.it("should be able to load user-config without errors", function()
    config:load(user_config_path)
    local errmsg = vim.fn.eval "v:errmsg"
    local exception = vim.fn.eval "v:exception"
    assert.equal("", errmsg) -- v:errmsg was not updated.
    assert.equal("", exception)
  end)

  a.it("should be able to reload user-config without errors", function()
    vim.opt.undodir = "/tmp"
    assert.equal(vim.opt.undodir:get()[1], "/tmp")
    config:reload()
    assert.equal(vim.opt.undodir:get()[1], utils.join_paths(get_cache_dir(), "undo"))
  end)

  a.it("should not get interrupted by errors in user-config", function()
    vim.opt.undodir = "/tmp"
    assert.equal(vim.opt.undodir:get()[1], "/tmp")
    os.execute(string.format("echo 'bad_string_test' >> %s", user_config_path))
    local error_handler = function(msg)
      return msg
    end
    local err = xpcall(config:reload(), error_handler)
    assert.falsy(err)
    assert.equal(vim.opt.undodir:get()[1], utils.join_paths(get_cache_dir(), "undo"))
    os.execute(string.format("echo '' > %s", user_config_path))
  end)
end)
