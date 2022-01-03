local a = require "plenary.async_lib.tests"
local config = require "lvim.config"

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
    config:load(user_config_path)
    local test_path = "/tmp/lvim"
    os.execute(string.format([[echo "vim.opt.undodir = '%s'" >> %s]], test_path, user_config_path))
    config:reload()
    assert.equal(vim.opt.undodir:get()[1], test_path)
  end)

  a.it("should not get interrupted by errors in user-config", function()
    local test_path = "/tmp/lunarvim"
    os.execute(string.format([[echo "vim.opt.undodir = '%s'" >> %s]], test_path, user_config_path))
    config:reload()
    assert.equal(vim.opt.undodir:get()[1], test_path)
    os.execute(string.format("echo 'bad_string_test' >> %s", user_config_path))
    local error_handler = function(msg)
      return msg
    end
    local err = xpcall(config:reload(), error_handler)
    assert.falsy(err)
    assert.equal(vim.opt.undodir:get()[1], test_path)
    local errmsg = vim.fn.eval "v:errmsg"
    local exception = vim.fn.eval "v:exception"
    assert.equal("", errmsg) -- v:errmsg was not updated.
    assert.equal("", exception)
    os.execute(string.format("echo '' > %s", user_config_path))
  end)
end)
