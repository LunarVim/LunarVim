local M = {}

local defaults = {
  active = false,
  on_config_done = nil,
  config = {
    breakpoint = {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
  },
  which_key = {
    values = {
      normal_mode = {
        d = {
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
          q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
        },
      },
    },
    opts = {
      normal_mode = {
        silent = true,
        noremap = true,
        nowait = true,
      },
    },
  },
}

function M:setup(overrides)
  local Config = require "config"
  self.config = Config(defaults):merge(overrides).entries
end

function M:configure()
  local dap = require "dap"

  vim.fn.sign_define("DapBreakpoint", self.config.config.breakpoint)
  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

  local which_key = require "core.builtins.which-key"
  which_key:register(self.config.which_key.values, self.config.which_key.opts)

  if self.config.on_config_done then
    self.config.on_config_done(dap)
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
