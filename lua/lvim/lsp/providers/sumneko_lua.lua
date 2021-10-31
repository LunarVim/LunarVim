local opts = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "lvim" },
      },
      workspace = {
        library = {
          -- TODO
          [require("lvim.utils").join_paths(get_config_dir(), "lua")] = true,
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
return opts
