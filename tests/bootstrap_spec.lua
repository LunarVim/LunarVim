local a = require "plenary.async_lib.tests"

a.describe("initial start", function()
  local uv = vim.loop
  local home_dir = uv.os_homedir()
  local lvim_config_path = home_dir .. "/.config/lvim"
  local lvim_runtime_path = home_dir .. "/.local/share/lunarvim/lvim"
  a.it("should not be reading default neovim directories in the home directoies", function()
    local rtp_list = vim.opt.rtp:get()
    local found_illegal_path = vim.tbl_contains(rtp_list, vim.fn.stdpath "config")
    assert.same(found_illegal_path, false)
  end)
  a.it("should be able to read lunarvim directories", function()
    local rtp_list = vim.opt.rtp:get()
    assert.is_true(vim.tbl_contains(rtp_list, lvim_runtime_path))
    assert.is_true(vim.tbl_contains(rtp_list, lvim_config_path))
  end)
  a.it("should be able to run treesitter without errors", function()
    vim.cmd [[TSInstall lua]]
    local status, _ = pcall(vim.treesitter.require_language, "lua")
    assert.is_true(status)
  end)
  a.it("should be able to run packer compile without errors", function()
    assert.truthy(package.loaded["packer"] ~= nil)
    -- FIXME: this rest of the test is pointless, why is packer not returning a status?
    local packer = require "packer"
    _G.packer_compile_status = false
    packer.on_compile_done = function()
      _G.packer_compile_status = true
    end
    packer.compile()
    assert.is_true(_G.packer_compile_status)
  end)
end)
