local M = {}

M.config = function()
  -- TODO: implement config for language
  return "No config available!"
end

M.format = function()
  -- TODO: implement formatter for language
  return "No formatter available!"
end

M.lint = function()
  -- TODO: implement linters (if applicable)
  return "No linters configured!"
end

M.lsp = function()
  if require("lv-utils").check_lsp_client_active "zls" then
    return
  end
  -- Because lspinstall don't support zig yet,
  -- So we need zls preset in global lib
  -- Further custom install zls in
  -- https://github.com/zigtools/zls/wiki/Downloading-and-Building-ZLS
  require("lspconfig").zls.setup {
    root_dir = require("lspconfig").util.root_pattern(".git", "build.zig", "zls.json"),
    on_attach = require("lsp").common_on_attach,
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
