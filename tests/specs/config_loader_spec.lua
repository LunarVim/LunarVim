local a = require "plenary.async_lib.tests"
local config = require "lvim.config"
local fmt = string.format

a.describe("config-loader", function()
  local user_config_path = join_paths(get_config_dir(), "config.lua")
  local default_config_path = join_paths(get_lvim_base_dir(), "utils", "installer", "config.example.lua")

  before_each(function()
    os.execute(fmt("cp -f %s %s", default_config_path, user_config_path))
    vim.cmd [[
	    let v:errmsg = ""
      let v:errors = []
    ]]
  end)

  after_each(function()
    local errmsg = vim.fn.eval "v:errmsg"
    local exception = vim.fn.eval "v:exception"
    local errors = vim.fn.eval "v:errors"
    assert.equal("", errmsg)
    assert.equal("", exception)
    assert.True(vim.tbl_isempty(errors))
  end)

  a.it("should be able to find user-config", function()
    assert.equal(user_config_path, get_config_dir() .. "/config.lua")
  end)

  a.it("should be able to load user-config without errors", function()
    config:load(user_config_path)
  end)

  a.it("should be able to reload user-config without errors", function()
    config:load(user_config_path)
    local test_path = "/tmp/lvim"
    os.execute(string.format([[echo "vim.opt.undodir = '%s'" >> %s]], test_path, user_config_path))
    config:reload()
    vim.schedule(function()
      assert.equal(vim.opt.undodir:get()[1], test_path)
    end)
  end)

  a.it("should not get interrupted by errors in user-config", function()
    local test_path = "/tmp/lunarvim"
    os.execute(string.format([[echo "vim.opt.undodir = '%s'" >> %s]], test_path, user_config_path))
    config:load(user_config_path)
    assert.equal(vim.opt.undodir:get()[1], test_path)
    require("lvim.core.log"):set_level "error"
    os.execute(string.format("echo 'invalid_function()' >> %s", user_config_path))
    config:load(user_config_path)
    require("lvim.core.log"):set_level "error"
    assert.equal(vim.opt.undodir:get()[1], test_path)
  end)
end)
