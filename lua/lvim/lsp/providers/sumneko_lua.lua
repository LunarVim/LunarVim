local dev_opts = {
  library = {
    vimruntime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    -- plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    plugins = { "plenary.nvim" },
  },
  override = nil, -- function(root_dir, options) end,
}

local lua_dev_loaded, lua_dev = pcall(require, "lua-dev")
if lua_dev_loaded then
  lua_dev.setup(dev_opts)
end

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
