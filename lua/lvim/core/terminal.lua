local M = {}
local Log = require "lvim.core.log"

M.config = function()
  lvim.builtin.terminal = {
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
    terminals_defaults = {
      direction = "horizontal",
      horizontal_size = 0.3,
      vertical_size = 0.4,
    },
    terminals = {
      { keymap = "<M-1>", desc = "Horizontal Terminal", direction = "horizontal" },
      { keymap = "<M-2>", desc = "Vertical Terminal", direction = "vertical" },
      { keymap = "<M-3>", desc = "Float Terminal", direction = "float" },
      { keymap = "<leader>gg", desc = "LazyGit", cmd = "lazygit", size = 1 },
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

local function term_toggle(term_opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new(term_opts)
  term:toggle(term_opts.size, term_opts.direction)
end

local function add_term_keymap(term_opts)
  local binary = term_opts.cmd:match "(%S+)"
  if vim.fn.executable(binary) ~= 1 then
    Log:debug("Skipping configuring executable " .. binary .. ". Please make sure it is installed properly.")
    return
  end

  local modes = { "n" }
  if not term_opts.keymap:find "<leader>" and not term_opts.keymap:find "<space>" then
    table.insert(modes, "t")
  end
  vim.keymap.set(modes, term_opts.keymap, function()
    term_toggle(term_opts)
  end, { desc = term_opts.desc, silent = true })
end

--- Setup the terminal cmds
M.init = function()
  for i, term_opts in ipairs(lvim.builtin.terminal.terminals) do
    -- size == 1 is a special case for full screen
    if term_opts.size == 1 then
      term_opts.direction = "float"
      term_opts.float_opts = term_opts.float_opts
        or {
          border = "none",
          width = 100000,
          height = 100000,
        }
    end

    term_opts.direction = term_opts.direction or lvim.builtin.terminal.terminals_defaults.direction
    term_opts.size = term_opts.size or lvim.builtin.terminal.terminals_defaults[term_opts.direction .. "_size"]
    -- size is calculated dynamically as a percentage of the current buffer
    term_opts.size = get_dynamic_terminal_size(term_opts.direction, term_opts.size)
    term_opts.cmd = term_opts.cmd or lvim.builtin.terminal.shell or vim.o.shell
    -- desc is used for the keymap description
    term_opts.desc = term_opts.desc or term_opts.cmd

    term_opts.count = i + 100

    -- the table is passed to toggleterm:new directly
    add_term_keymap(term_opts)
  end
end

M.setup = function()
  local terminal = require "toggleterm"
  terminal.setup(lvim.builtin.terminal)
  if lvim.builtin.terminal.on_config_done then
    lvim.builtin.terminal.on_config_done(terminal)
  end
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
