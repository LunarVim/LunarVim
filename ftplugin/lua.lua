O.formatters.filetype["lua"] = {
  function()
    return {
      exe = O.lang.lua.formatter.exe,
      args = O.lang.lua.formatter.args,
      stdin = not (O.lang.lua.formatter.stdin ~= nil),
    }
  end,
}

require("formatter.config").set_defaults {
  logging = false,
  filetype = O.formatters.filetype,
}
if not require("lv-utils").check_lsp_client_active "sumneko_lua" then
  -- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
  local sumneko_root_path = DATA_PATH .. "/lspinstall/lua"
  local sumneko_binary = sumneko_root_path .. "/sumneko-lua-language-server"

  require("lspconfig").sumneko_lua.setup {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    on_attach = require("lsp").common_on_attach,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 1000,
        },
      },
    },
  }
end
