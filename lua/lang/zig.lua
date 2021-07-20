local M = {}

M.config = function()
  O.lang.zig = {
    lsp_path = "zls",
    formatter = {
      exe = "zig",
      args = { "fmt" },
      stdin = false,
    },
  }
end

M.format = function()
  O.formatters.filetype["zig"] = {
    function()
      return {
        exe = O.lang.zig.formatter.exe,
        args = O.lang.zig.formatter.args,
        stdin = O.lang.zig.formatter.stdin,
      }
    end,
  }

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
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
    cmd = { O.lang.zig.lsp_path },
    root_dir = require("lspconfig").util.root_pattern(".git", "build.zig", "zls.json"),
    on_attach = require("lsp").common_on_attach,
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
