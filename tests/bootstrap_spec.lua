local a = require "plenary.async_lib.tests"

a.describe("initial start", function()
  local uv = vim.loop
  local home_dir = uv.os_homedir()
  local lvim_config_path = get_config_dir() or home_dir .. "/.config/lvim"
  local lvim_runtime_path = get_runtime_dir() or home_dir .. "/.local/share/lunarvim"

  a.it("shoud be able to detect test environment", function()
    assert.truthy(os.getenv "LVIM_TEST_ENV")
    assert.falsy(package.loaded["impatient"])
  end)

  a.it("should not be reading default neovim directories in the home directoies", function()
    local rtp_list = vim.opt.rtp:get()
    assert.falsy(vim.tbl_contains(rtp_list, vim.fn.stdpath "config"))
  end)

  a.it("should be able to read lunarvim directories", function()
    local rtp_list = vim.opt.rtp:get()
    assert.truthy(vim.tbl_contains(rtp_list, lvim_runtime_path .. "/lvim"))
    assert.truthy(vim.tbl_contains(rtp_list, lvim_config_path))
  end)

  a.it("should be able to run treesitter without errors", function()
    assert.truthy(vim.treesitter.highlighter.active)
  end)
end)
