local a = require "plenary.async_lib.tests"

a.describe("plugin-loader", function()
  local plugins = require "lvim.plugins"
  local loader = require "lvim.plugin-loader"

  a.it("should be able to load default packages without errors", function()
    loader:load { plugins, lvim.plugins }

    -- TODO: maybe there's a way to avoid hard-coding the names of the modules?
    local startup_plugins = {
      "packer",
    }

    for _, plugin in ipairs(startup_plugins) do
      assert.truthy(package.loaded[plugin])
    end
  end)

  a.it("should be able to load lsp packages without errors", function()
    loader:load { plugins, lvim.plugins }

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
end)
