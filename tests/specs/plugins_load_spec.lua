local a = require "plenary.async_lib.tests"

a.describe("plugin-loader", function()
  local plugins = require "lvim.plugins"
  local loader = require "lvim.plugin-loader"

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
  a.it("should be able to rollback plugins without errors", function()
    local plugin = { name = "onedarker.nvim" }
    plugin.path = vim.tbl_filter(function(package)
      return package:match(plugin.name)
    end, vim.api.nvim_list_runtime_paths())[1]

    plugin.test_sha = "316b1c9"
    local get_current_sha = function(repo)
      local res = vim.fn.system(string.format("git -C %s log -1 --pretty=%%h", repo)):gsub("\n", "")
      return res
    end
    local get_locked_sha = function(p)
      local default_snapshot = get_lvim_base_dir() .. "/snapshots/default.json"
      local res = vim.fn.system(string.format([[jq -r '."%s".commit' %s]], p, default_snapshot)):gsub("\n", "")
      return res
    end
    loader.load { plugins, lvim.plugins }

    os.execute(string.format("git -C %s fetch --deepen 999", plugin.path))
    os.execute(string.format("git -C %s checkout %s", plugin.path, plugin.test_sha))
    assert.equal(plugin.test_sha, get_current_sha(plugin.path))
    local packer_logfile = vim.fn.stdpath "cache" .. "/packer.nvim.log"
    os.execute("echo '' > " .. packer_logfile)
    loader.sync_core_plugins()
    local locked_sha = get_locked_sha(plugin.name)
    vim.wait(60 * 1000)
    print(locked_sha)
    -- assert.True(ret)
  end)
end)
