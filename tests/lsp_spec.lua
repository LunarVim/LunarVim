local a = require "plenary.async_lib.tests"
local utils = require "utils"

a.describe("lsp workflow", function()
  local Log = require "core.log"
  local logfile = Log:get_path()

  a.it("shoud be able to delete ftplugin templates", function()
    if utils.is_directory(lvim.lsp.templates_dir) then
      assert.equal(vim.fn.delete(lvim.lsp.templates_dir, "rf"), 0)
    end
    assert.False(utils.is_directory(lvim.lsp.templates_dir))
  end)

  a.it("shoud be able to generate ftplugin templates", function()
    if utils.is_directory(lvim.lsp.templates_dir) then
      assert.equal(vim.fn.delete(lvim.lsp.templates_dir, "rf"), 0)
    end
    require("lsp").setup()

    -- we need to delay this check until the generation is completed
    vim.schedule(function()
      assert.True(utils.is_directory(lvim.lsp.templates_dir))
    end)
  end)

  a.it("shoud not attempt to re-generate ftplugin templates", function()
    lvim.log.level = "debug"

    local plugins = require "plugins"
    require("plugin-loader"):load { plugins, lvim.plugins }

    if utils.is_file(logfile) then
      assert.equal(vim.fn.delete(logfile), 0)
    end

    assert.True(utils.is_directory(lvim.lsp.templates_dir))
    require("lsp").setup()

    local _, ret, _ = utils.search_lvim_log { "templates" }
    assert.equal(ret, 1)
  end)
end)
