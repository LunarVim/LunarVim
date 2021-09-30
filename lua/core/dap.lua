local M = {}

M.config = function()
  lvim.builtin.dap = {
    active = false,
    on_config_done = nil,
    breakpoint = {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    breakpoint_rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }
end

M.setup = function()
  local dap = require "dap"

  vim.fn.sign_define("DapBreakpoint", lvim.builtin.dap.breakpoint)
  vim.fn.sign_define("DapBreakpointRejected", lvim.builtin.dap.breakpoint_rejected)
  vim.fn.sign_define("DapStopped", lvim.builtin.dap.stopped)

  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

  if lvim.builtin.dap.on_config_done then
    lvim.builtin.dap.on_config_done(dap)
  end
end

-- TODO put this up there ^^^ call in ftplugin

-- M.dap = function()
--   if lvim.plugin.dap.active then
--     local dap_install = require "dap-install"
--     dap_install.config("python_dbg", {})
--   end
-- end
--
-- M.dap = function()
--   -- gem install readapt ruby-debug-ide
--   if lvim.plugin.dap.active then
--     local dap_install = require "dap-install"
--     dap_install.config("ruby_vsc_dbg", {})
--   end
-- end

return M
