O.formatters.filetype["c"] = {
  function()
    return {
      exe = O.lang.c.formatter.exe,
      args = O.lang.c.formatter.args,
      stdin = not (O.lang.c.formatter.stdin ~= nil),
    }
  end,
}
O.formatters.filetype["cpp"] = O.formatters.filetype["c"]

require("formatter.config").set_defaults {
  logging = false,
  filetype = O.formatters.filetype,
}

if require("lv-utils").check_lsp_client_active "clangd" then
  return
end

local clangd_flags = { "--background-index" }

if O.lang.clang.cross_file_rename then
  table.insert(clangd_flags, "--cross-file-rename")
end

table.insert(clangd_flags, "--header-insertion=" .. O.lang.clang.header_insertion)

require("lspconfig").clangd.setup {
  cmd = { DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd", unpack(clangd_flags) },
  on_attach = require("lsp").common_on_attach,
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = O.lang.clang.diagnostics.virtual_text,
      signs = O.lang.clang.diagnostics.signs,
      underline = O.lang.clang.diagnostics.underline,
      update_in_insert = true,
    }),
  },
}
