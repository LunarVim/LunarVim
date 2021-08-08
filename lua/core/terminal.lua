local M = {}
local Log = require "core.log"
M.config = function()
  lvim.builtin["terminal"] = {
    -- size can be a number or function which is passed the current terminal
    size = 20,
    -- open_mapping = [[<c-\>]],
    open_mapping = [[<c-t>]],
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
    shell = vim.o.shell, -- change the default shell
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
    -- Add executables on the config.lua
    -- { exec, keymap, name}
    -- lvim.builtin.terminal.execs = {{}} to overwrite
    -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
    execs = {
      { "lazygit", "gg", "LazyGit" },
    },
  }
end

M.setup = function()
  local status_ok, terminal = pcall(require, "toggleterm")
  if not status_ok then
    Log:get_default().error "Failed to load toggleterm"
    print(terminal)
    return
  end
  for _, exec in pairs(lvim.builtin.terminal.execs) do
    require("core.terminal").add_exec(exec[1], exec[2], exec[3])
  end
  terminal.setup(lvim.builtin.terminal)
end

local function is_installed(exe)
  return vim.fn.executable(exe) == 1
end

M.add_exec = function(exec, keymap, name)
  vim.api.nvim_set_keymap(
    "n",
    "<leader>" .. keymap,
    "<cmd>lua require('core.terminal')._exec_toggle('" .. exec .. "')<CR>",
    { noremap = true, silent = true }
  )
  lvim.builtin.which_key.mappings[keymap] = name
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
  if is_installed(binary) ~= true then
    print("Please install executable " .. binary .. ". Check documentation for more information")
    return
  end
  local Terminal = require("toggleterm.terminal").Terminal
  local exec_term = Terminal:new { cmd = exec, hidden = true }
  exec_term:toggle()
end

---Use toggle term to view the live log
---@param name of the logfile, e,g: {lunarvim, lsp, neovim, packer}
M.toggle_log_view = function(name)
  --- NOTE: this is hardcoded in Plenary unfortunately
  local logfile = CACHE_PATH .. "/" .. name .. ".log"
  -- handle custom paths not managed by Plenary.log
  if name == "nvim" then
    logfile = CACHE_PATH .. "log"
  elseif name == "packer" then
    logfile = CACHE_PATH .. "/packer.nvim.log"
  end

  local view_cmd = lvim.log.viewer .. " " .. logfile

  local term_opts = vim.tbl_extend("keep", {
    cmd = view_cmd,
    open_mapping = [[<M-t>]],
    direction = "horizontal",
    -- FIXME: this isn't working
    size = 40,
    float_opts = { winblend = 3 },
    hidden = true,
    start_in_insert = true,
  }, lvim.builtin.terminal)

  local Terminal = require("toggleterm.terminal").Terminal
  local log_view = Terminal:new(term_opts)
  -- require("core.log"):get_default().debug("term", vim.inspect(term_opts))
  log_view:toggle()
end

return M
