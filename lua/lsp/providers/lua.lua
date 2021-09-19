local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "sumneko_lua",
    setup = {
      cmd = {
        lvim.lsp.ls_install_prefix .. "/lua/sumneko-lua-language-server",
        "-E",
        lvim.lsp.ls_install_prefix .. "/lua/main.lua",
      },
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "lvim" },
          },
          runtime = {
            path = {
              "./?.lua",
              "/home/hatsu/.local/share/neovim/.deps/usr/share/luajit-2.1.0-beta3/?.lua",
              "/usr/local/share/lua/5.1/?.lua",
              "/usr/local/share/lua/5.1/?/init.lua",
              "/home/hatsu/.local/share/neovim/.deps/usr/share/lua/5.1/?.lua",
              "/home/hatsu/.local/share/neovim/.deps/usr/share/lua/5.1/?/init.lua",
              "/home/hatsu/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua",
              "/home/hatsu/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua",
              "/home/hatsu/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua",
              "/home/hatsu/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua",
            },
            version = "LuaJIT",
          },
          workspace = {
            library = {
              ["/home/hatsu/.local/share/lunarvim/lvim/lua"] = true,
              ["/usr/local/share/nvim/runtime/lua"] = true,
              ["/usr/local/share/nvim/runtime/lua/vim/lsp"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 1000,
          },
        },
      },
    },
  },
}
return opts
