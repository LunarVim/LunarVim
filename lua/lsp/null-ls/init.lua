local M = {}

function M.setup(filetype)
  require("lsp.null-ls.formatters").setup(filetype)
  -- require("lsp.null-ls.linters").setup(filetype)
end

return M
