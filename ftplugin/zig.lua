-- Because lspinstall don't support zig yet,
-- So we need zls preset in global lib
-- Further custom install zls in
-- https://github.com/zigtools/zls/wiki/Downloading-and-Building-ZLS
require("lspconfig").zls.setup {
  root_dir = require("lspconfig").util.root_pattern(".git", "build.zig", "zls.json"),
  on_attach = require("lsp").common_on_attach,
}
require("lv-utils").define_augroups {
  _zig_autoformat = {
    { "BufEnter", "*.zig", ':lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")' },
  },
}
vim.cmd "setl expandtab tabstop=8 softtabstop=4 shiftwidth=4"
