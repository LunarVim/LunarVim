local M = {}

M.config = function()
  O.lang.yaml = {
    formatter = {
      exe = "prettier",
      args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
    },
  }
end

M.format = function()
  -- TODO: implement formatter for language
  return "No formatter available!"
end

M.lint = function()
  -- TODO: implement linters (if applicable)
  return "No linters configured!"
end

M.lsp = function() end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
