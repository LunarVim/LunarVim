local default_workspace = {
  library = {
    vim.fn.expand "$VIMRUNTIME",
    get_lvim_base_dir(),
    require("neodev.config").types(),
    "${3rd}/busted/library",
    "${3rd}/luassert/library",
    "${3rd}/luv/library",
  },

  maxPreload = 5000,
  preloadFileSize = 10000,
}

local add_packages_to_workspace = function(packages, config)
  -- config.settings.Lua = config.settings.Lua or { workspace = default_workspace }
  local runtimedirs = vim.api.nvim__get_runtime({ "lua" }, true, { is_lua = true })
  local workspace = config.settings.Lua.workspace
  for _, v in pairs(runtimedirs) do
    for _, pack in ipairs(packages) do
      if v:match(pack) and not vim.tbl_contains(workspace.library, v) then
        table.insert(workspace.library, v)
      end
    end
  end
end

local lspconfig = require "lspconfig"

local make_on_new_config = function(on_new_config, _)
  return lspconfig.util.add_hook_before(on_new_config, function(new_config, _)
    local server_name = new_config.name

    if server_name ~= "lua_ls" then
      return
    end
    local plugins = { "plenary.nvim", "telescope.nvim", "nvim-treesitter", "LuaSnip" }
    add_packages_to_workspace(plugins, new_config)
  end)
end

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  on_new_config = make_on_new_config(lspconfig.util.default_config.on_new_config),
})

local opts = {
  settings = {
    Lua = {
      telemetry = { enable = false },
      runtime = {
        version = "LuaJIT",
        special = {
          reload = "require",
        },
      },
      diagnostics = {
        globals = { "vim", "lvim", "reload" },
      },
      workspace = default_workspace,
    },
  },
}

return opts
