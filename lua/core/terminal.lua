local M = {
  defaults = {
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
  },
}

local utils = require "utils"

function M:setup(config)
  config:extend_with(self.defaults)
end

function M:config()
  local terminal = require "toggleterm"

  for _, exec in pairs(lvim.builtins.terminal.execs) do
    M.add_exec(exec[1], exec[2], exec[3])
  end
  terminal.setup(lvim.builtins.terminal.config)

  if lvim.builtins.terminal.on_config_done then
    lvim.builtins.terminal.on_config_done(terminal)
  end
end

M.add_exec = function(exec, keymap, name)
  vim.api.nvim_set_keymap(
    "n",
    "<leader>" .. keymap,
    "<cmd>lua require('core.terminal')._exec_toggle('" .. exec .. "')<CR>",
    { noremap = true, silent = true }
  )
  lvim.builtins.which_key.mappings[keymap] = name
end

M._split = function(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

M._exec_toggle = function(exec)
  local binary = M._split(exec)[1]
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
M.toggle_log_view = function(name)
  local logfile = get_log_path(name)
  if not logfile then
    return
  end
  local term_opts = vim.tbl_deep_extend("force", lvim.builtins.terminal.config, {
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
