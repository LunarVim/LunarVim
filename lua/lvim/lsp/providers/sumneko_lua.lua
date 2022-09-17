local dev_opts = {
  library = {
    vimruntime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    -- plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    plugins = { "plenary.nvim", "telescope.nvim", "nvim-treesitter", "packer.nvim", "LuaSnip" },
  },
  override = function(root_dir, library)
    -- workaround for hard-coded lua_dev.util.is_nvim_config()
    if root_dir == get_config_dir() or root_dir == get_lvim_base_dir() then
      library.enabled = true
      library.plugins = { "plenary.nvim", "telescope.nvim", "nvim-treesitter", "packer.nvim", "LuaSnip" }
    end
  end,
}

local lua_dev_loaded, lua_dev = pcall(require, "lua-dev")
if lua_dev_loaded then
  lua_dev.setup(dev_opts)
end

local lspconfig = require "lspconfig"

local make_on_new_config = function(on_new_config)
  return lspconfig.util.add_hook_before(on_new_config, function(new_config, _)
    local server_name = new_config.name

    if server_name ~= "sumneko_lua" then
      return
    end
    -- this is otherwise getting overwritten by lua_dev.lsp.on_new_config()
    new_config.settings.Lua = new_config.settings.Lua or { workspace = { library = {} } }
    table.insert(new_config.settings.Lua.workspace.library, get_lvim_base_dir())
  end)
end

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  on_new_config = make_on_new_config(lspconfig.util.default_config.on_new_config),
})

local opts = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "lvim", "packer_plugins" },
      },
      workspace = {
        library = {
          [require("lvim.utils").join_paths(get_runtime_dir(), "lvim", "lua")] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

return opts
