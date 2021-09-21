local opts = {
  settings = {
    Lua = {
      diagnostics = {
        -- globals = { "vim", "lvim" },
      },
      runtime = {
        path = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        version = "LuaJIT",
      },
      workspace = {
        library = {
          [require("utils").join_paths(get_runtime_dir(), "lvim", "lua")] = true,
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 1000,
      },
    },
  },
}
return opts
