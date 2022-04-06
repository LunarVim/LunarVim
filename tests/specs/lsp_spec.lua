local a = require "plenary.async_lib.tests"
local utils = require "lvim.utils"
local helpers = require "tests.lvim.helpers"
local temp_dir = vim.loop.os_getenv "TEMP" or "/tmp"
lvim.lsp.templates_dir = join_paths(temp_dir, "lvim", "tests", "artifacts")

a.describe("lsp workflow", function()
  local Log = require "lvim.core.log"
  local logfile = Log:get_path()

  a.it("should be able to delete ftplugin templates", function()
    if utils.is_directory(lvim.lsp.templates_dir) then
      assert.equal(vim.fn.delete(lvim.lsp.templates_dir, "rf"), 0)
    end
    assert.False(utils.is_directory(lvim.lsp.templates_dir))
  end)

  a.it("should be able to generate ftplugin templates", function()
    if utils.is_directory(lvim.lsp.templates_dir) then
      assert.equal(vim.fn.delete(lvim.lsp.templates_dir, "rf"), 0)
    end
    require("lvim.lsp").setup()

    -- we need to delay this check until the generation is completed
    vim.schedule(function()
      assert.True(utils.is_directory(lvim.lsp.templates_dir))
    end)
  end)

  a.it("should not attempt to re-generate ftplugin templates", function()
    lvim.log.level = "debug"

    local plugins = require "lvim.plugins"
    require("lvim.plugin-loader").load { plugins, lvim.plugins }

    if utils.is_file(logfile) then
      assert.equal(vim.fn.delete(logfile), 0)
    end

    assert.True(utils.is_directory(lvim.lsp.templates_dir))
    require("lvim.lsp").setup()

    -- we need to delay this check until the log gets populated
    vim.schedule(function()
      assert.False(helpers.log_contains "templates")
    end)
  end)

  a.it("should not include blacklisted servers in the generated templates", function()
    assert.True(utils.is_directory(lvim.lsp.templates_dir))
    require("lvim.lsp").setup()

    for _, file in ipairs(vim.fn.glob(lvim.lsp.templates_dir .. "/*.lua", 1, 1)) do
      for _, server_name in ipairs(lvim.lsp.override) do
        local setup_cmd = string.format([[require("lvim.lsp.manager").setup(%q)]], server_name)
        assert.False(helpers.file_contains(file, setup_cmd))
      end
    end
  end)

  a.it("should only include one server per generated template", function()
    assert.True(utils.is_directory(lvim.lsp.templates_dir))
    require("lvim.lsp").setup()

    for _, file in ipairs(vim.fn.glob(lvim.lsp.templates_dir .. "/*.lua", 1, 1)) do
      local content = {}
      for entry in io.lines(file) do
        table.insert(content, entry)
      end
      local err_msg = ""
      if #content > 1 then
        err_msg = string.format(
          "found more than one server for [%q]: \n{\n %q \n}",
          file:match "[^/]*.lua$",
          table.concat(content, ", ")
        )
      end
      assert.equal(err_msg, "")
    end
  end)
end)
