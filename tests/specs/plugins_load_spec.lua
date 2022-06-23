local a = require "plenary.async_lib.tests"

a.describe("plugin-loader", function()
  local plugins = require "lvim.plugins"
  local loader = require "lvim.plugin-loader"

  pcall(function()
    lvim.log.level = "debug"
    package.loaded["packer.log"] = nil
    package.loaded["lvim.core.log"] = nil
  end)

  a.it("should be able to load default packages without errors", function()
    loader.load { plugins, lvim.plugins }

    -- TODO: maybe there's a way to avoid hard-coding the names of the modules?
    local startup_plugins = {
      "packer",
    }

    for _, plugin in ipairs(startup_plugins) do
      assert.truthy(package.loaded[plugin])
    end
  end)

  a.it("should be able to load lsp packages without errors", function()
    loader.load { plugins, lvim.plugins }

    require("lvim.lsp").setup()

    local lsp_packages = {
      "lspconfig",
      "nlspsettings",
      "null-ls",
    }

    for _, plugin in ipairs(lsp_packages) do
      assert.truthy(package.loaded[plugin])
    end
  end)

  pending("should be able to rollback plugins without errors", function()
    local plugin = { name = "onedarker.nvim" }
    plugin.path = vim.tbl_filter(function(package)
      return package:match(plugin.name)
    end, vim.api.nvim_list_runtime_paths())[1]

    local get_current_sha = function(repo)
      local res = vim.fn.system(string.format("git -C %s log -1 --pretty=%%h", repo)):gsub("\n", "")
      return res
    end
    plugin.test_sha = "316b1c9"
    _G.locked_sha = get_current_sha(plugin.path)
    loader.load { plugins, lvim.plugins }

    os.execute(string.format("git -C %s fetch --deepen 999 --quiet", plugin.path))
    os.execute(string.format("git -C %s checkout %s --quiet", plugin.path, plugin.test_sha))
    assert.equal(plugin.test_sha, get_current_sha(plugin.path))
    _G.completed = false
    _G.verify_sha = function()
      if _G.locked_sha ~= get_current_sha(plugin.path) then
        error "unmached results!"
      else
        _G.completed = true
      end
    end
    vim.cmd [[autocmd User PackerComplete ++once lua _G.verify_sha()]]
    loader.load_snapshot()
    local ret = vim.wait(30 * 10 * 1000, function()
      return _G.completed == true
    end, 200)
    assert.True(ret)
  end)
end)
