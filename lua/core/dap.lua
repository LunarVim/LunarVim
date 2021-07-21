local M = {}
M.config = function()
  O.plugin.dap = {
    active = false,
    breakpoint = {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
  }
end

M.setup = function()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  vim.fn.sign_define("DapBreakpoint", O.plugin.dap.breakpoint)
  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

  O.plugin.which_key.mappings["d"] = {
    name = "Debug",
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    q = { "<cmd>lua require'dap'.stop()<cr>", "Quit" },
  }
end

-- TODO put this up there ^^^ call in ftplugin

M.dap = function()
  if O.plugin.dap.active then
    local dap_install = require "dap-install"
    dap_install.config("python_dbg", {})
  end
end

return M
