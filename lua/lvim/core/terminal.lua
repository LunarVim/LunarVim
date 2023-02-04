local M = {}
local Log = require "lvim.core.log"

M.config = function()
  lvim.builtin["terminal"] = {
    active = true,
    on_config_done = nil,
    -- size can be a number or function which is passed the current terminal
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = nil, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_win_open'
      -- see :h nvim_win_open for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      border = "curved",
      -- width = <value>,
      -- height = <value>,
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    execs = {
      defaults = {
        direction = "horizontal",
        horizontal_size = 0.3,
        vertical_size = 0.4,
      },
      { keymap = "<M-1>", direction = "horizontal" },
      { keymap = "<M-2>", direction = "vertical" },
      { keymap = "<M-3>", direction = "float" },
      { keymap = "<leader>gg", cmd = "lazygit", size = 1 },
    },
  }
end

--- Get current buffer size
---@return {width: number, height: number}
local function get_buf_size()
  local cbuf = vim.api.nvim_get_current_buf()
  local bufinfo = vim.tbl_filter(function(buf)
    return buf.bufnr == cbuf
  end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
  if bufinfo == nil then
    return { width = -1, height = -1 }
  end
  return { width = bufinfo.width, height = bufinfo.height }
end

--- Get the dynamic terminal size in cells
---@param direction number
---@param size number
---@return integer
local function get_dynamic_terminal_size(direction, size)
  size = size or lvim.builtin.terminal.size
  if direction ~= "float" and tostring(size):find(".", 1, true) then
    size = math.min(size, 1.0)
    local buf_sizes = get_buf_size()
    local buf_size = direction == "horizontal" and buf_sizes.height or buf_sizes.width
    return buf_size * size
  else
    return size
  end
end

M.init = function()
  -- vim.pretty_print(lvim.builtin.terminal.execs)
  for i, exec in ipairs(lvim.builtin.terminal.execs) do
    if exec.size == 1 then
      exec.direction = "float"
    end
    local direction = exec.direction or lvim.builtin.terminal.execs.defaults.direction
    local size = exec.size or lvim.builtin.terminal.execs.defaults[direction .. "_size"]
    size = get_dynamic_terminal_size(direction, size)
    local cmd = exec.cmd or lvim.builtin.terminal.shell
    local desc = exec.desc
    if desc == nil then
      if exec.cmd == nil then
        desc = "Toggle Terminal(" .. direction .. ")"
      else
        desc = exec.cmd
      end
    end

    local opts = {
      cmd = cmd,
      keymap = exec.keymap,
      desc = desc,
      -- NOTE: unable to consistently bind id/count <= 9, see #2146
      count = i + 100,
      direction = direction,
      size = size,
    }

    M.add_exec(opts)
  end
end

M.setup = function()
  local terminal = require "toggleterm"
  terminal.setup(lvim.builtin.terminal)
  if lvim.builtin.terminal.on_config_done then
    lvim.builtin.terminal.on_config_done(terminal)
  end
end

M.add_exec = function(opts)
  local binary = opts.cmd:match "(%S+)"
  if vim.fn.executable(binary) ~= 1 then
    Log:debug("Skipping configuring executable " .. binary .. ". Please make sure it is installed properly.")
    return
  end

  vim.keymap.set({ "n", "t" }, opts.keymap, function()
    M._exec_toggle { cmd = opts.cmd, count = opts.count, direction = opts.direction, size = opts.size }
  end, { desc = opts.desc, noremap = true, silent = true })
end

M._exec_toggle = function(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new {
    cmd = opts.cmd,
    count = opts.count,
    direction = opts.direction,
    float_opts = {
      border = "none" and opts.size == 1,
      width = opts.size == 1 and 100000,
      height = opts.size == 1 and 100000,
    },
  }
  term:toggle(opts.size, opts.direction)
end

---Toggles a log viewer according to log.viewer.layout_config
---@param logfile string the fullpath to the logfile
M.toggle_log_view = function(logfile)
  local log_viewer = lvim.log.viewer.cmd
  if vim.fn.executable(log_viewer) ~= 1 then
    log_viewer = "less +F"
  end
  Log:debug("attempting to open: " .. logfile)
  log_viewer = log_viewer .. " " .. logfile
  local term_opts = vim.tbl_deep_extend("force", lvim.builtin.terminal, {
    cmd = log_viewer,
    open_mapping = lvim.log.viewer.layout_config.open_mapping,
    direction = lvim.log.viewer.layout_config.direction,
    -- TODO: this might not be working as expected
    size = lvim.log.viewer.layout_config.size,
    float_opts = lvim.log.viewer.layout_config.float_opts,
  })

  local Terminal = require("toggleterm.terminal").Terminal
  local log_view = Terminal:new(term_opts)
  log_view:toggle()
end

return M
