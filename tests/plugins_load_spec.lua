local a = require "plenary.async_lib.tests"

a.describe("plugin-loader", function()
  a.it("should be able to load default packages without errors", function()
    local plugins = require "plugins"
    require("plugin-loader"):load { plugins, lvim.plugins }

    -- TODO: maybe there's a way to avoid hard-coding the names of the modules?
    local startup_plugins = {
      "packer",
    }

    for _, plugin in ipairs(startup_plugins) do
      assert.truthy(package.loaded[plugin])
    end
  end)

  a.it("should be able to load lsp packages without errors", function()
    local plugins = require "plugins"
    require("plugin-loader"):load { plugins, lvim.plugins }

    require("lsp").setup()

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
