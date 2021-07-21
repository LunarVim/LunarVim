require("core.formatter").setup("python", {
  exe = O.lang.python.formatter.exe,
  args = O.lang.python.formatter.args,
  stdin = O.lang.python.formatter.stdin,
})
require("lsp").setup("pyright", {
  O.lang.python.lsp.path,
  "--stdio",
})

require("lint").linters_by_ft = {
  python = O.lang.python.linters,
}
-- TODO get from dap
-- require("lang.python").dap()
