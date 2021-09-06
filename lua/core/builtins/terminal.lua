local M = {}

local defaults = {
  active = true,
  on_config_done = nil,
  config = {},
  -- Add executables on the config.lua
  -- { exec, keymap, name}
  -- lvim.builtins.terminal.execs = {{}} to overwrite
  -- table.insert(lvim.builtins.terminal.execs, {"gdb", "tg", "GNU Debugger"})
  execs = {
    { "lazygit", "gg", "LazyGit" },
  },
}
local utils = require "utils"

function M:setup(overrides)
  local Config = require "config"
  self.config = Config(defaults):merge(overrides).entries
end

function M:configure()
  local terminal = require "toggleterm"

  for _, exec in pairs(self.config.execs) do
    self.add_exec(exec[1], exec[2], exec[3])
  end
  terminal.setup(self.config.config)

  if self.config.on_config_done then
    self.config.on_config_done(terminal)
  end
end

function M.add_exec(exec, keymap, name)
  local which_key = require "core.builtins.which-key"
  which_key:register({
    normal_mode = {
      [keymap] = { "<cmd>lua require('core.builtins.terminal')._exec_toggle('" .. exec .. "')<CR>", name },
    },
  }, {
    normal_mode = {
      noremap = true,
      silent = true,
    },
  })
end

M._exec_toggle = function(exec)
  local split = function(inputstr, sep)
    if sep == nil then
      sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
      table.insert(t, str)
    end
    return t
  end

  local binary = split(exec)[1]
  if vim.fn.executable(binary) ~= 1 then
    local Log = require "core.log"
    Log:error("Unable to run executable " .. binary .. ". Please make sure it is installed properly.")
    return
  end
  local Terminal = require("toggleterm.terminal").Terminal
  local exec_term = Terminal:new { cmd = exec, hidden = true }
  exec_term:toggle()
end

local function get_log_path(name)
  --handle custom paths not managed by Plenary.log
  local logger = require "core.log"
  local file
  if name == "nvim" then
    file = CACHE_PATH .. "/log"
  else
    file = logger:new({ plugin = name }):get_path()
  end
  if utils.is_file(file) then
    return file
  end
end

---Toggles a log viewer according to log.viewer.layout_config
---@param name can be the name of any of the managed logs, e,g. "lunarvim" or the default ones {"nvim", "lsp", "packer.nvim"}
function M:toggle_log_view(name)
  local logfile = get_log_path(name)
  if not logfile then
    return
  end
  local term_opts = vim.tbl_deep_extend("force", self.config.config, {
    cmd = lvim.log.viewer.cmd .. " " .. logfile,
    open_mapping = lvim.log.viewer.layout_config.open_mapping,
    direction = lvim.log.viewer.layout_config.direction,
    -- TODO: this might not be working as expected
    size = lvim.log.viewer.layout_config.size,
    float_opts = lvim.log.viewer.layout_config.float_opts,
  })

  local Terminal = require("toggleterm.terminal").Terminal
  local log_view = Terminal:new(term_opts)
  -- require("core.log"):debug("term", vim.inspect(term_opts))
  log_view:toggle()
end

return M
