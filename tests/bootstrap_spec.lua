local a = require "plenary.async_lib.tests"

a.describe("initial start", function()
  local uv = vim.loop
  local home_dir = uv.os_homedir()
  -- TODO: update once #1381 is merged
  local lvim_config_path = home_dir .. "/.config/lvim"
  local lvim_runtime_path = home_dir .. "/.local/share/lunarvim/lvim"

  a.it("should not be reading default neovim directories in the home directoies", function()
    local rtp_list = vim.opt.rtp:get()
    assert.falsy(vim.tbl_contains(rtp_list, vim.fn.stdpath "config"))
  end)

  a.it("should be able to read lunarvim directories", function()
    local rtp_list = vim.opt.rtp:get()
    assert.truthy(vim.tbl_contains(rtp_list, lvim_runtime_path))
    assert.truthy(vim.tbl_contains(rtp_list, lvim_config_path))
  end)

  a.it("should be able to run treesitter without errors", function()
    assert.truthy(vim.treesitter.highlighter.active)
  end)

  a.it("should be able to load default packages without errors", function()
    -- TODO: maybe there's a way to avoid hard-coding the names of the modules?
    local startup_plugins = {
      "packer",
      "lspconfig",
      "nlspsettings",
      "null-ls",
    }
    for _, plugin in pairs(startup_plugins) do
      assert.truthy(package.loaded[tostring(plugin)])
    end
  end)
end)
