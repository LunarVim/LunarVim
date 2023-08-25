describe("plugin-loader", function()
  local plugins = require "lvim.plugins"
  local loader = require "lvim.plugin-loader"

  pcall(function()
    lvim.log.level = "debug"
    package.loaded["lvim.core.log"] = nil
  end)

  it("should be able to load default packages without errors", function()
    vim.go.loadplugins = true
    loader.load { plugins, lvim.plugins }

    -- TODO: maybe there's a way to avoid hard-coding the names of the modules?
    local startup_plugins = {
      "lazy",
    }

    for _, plugin in ipairs(startup_plugins) do
      assert.truthy(package.loaded[plugin])
    end
  end)

  it("should be able to load lsp packages without errors", function()
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
