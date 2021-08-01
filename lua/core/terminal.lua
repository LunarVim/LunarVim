local M = {}
M.config = function()
  lvim.builtin["terminal"] = {
    -- size can be a number or function which is passed the current terminal
    size = 5,
    -- open_mapping = [[<c-\>]],
    open_mapping = [[<c-t>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
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
    execs = { { "lazygit", "gg", "LazyGit" } },
    -- Add commands based on filetype to be launched using the terminal
    -- { filetype, keymap, cmd, name}
    ft_cmds = {},
  }
end

M.setup = function()
  local status_ok, terminal = pcall(require, "toggleterm")
  if not status_ok then
    print(terminal)
    return
  end
  for _, exec in pairs(lvim.builtin.terminal.execs) do
    require("core.terminal").add_exec(exec[1], exec[2], exec[3])
  end

  vim.cmd "augroup Terminal_Filetype_autocommands"
  vim.cmd "autocmd!"
  for _, ft_cmd in pairs(lvim.builtin.terminal.ft_cmds) do
    local cmd = "nnoremap <leader>"
      .. ft_cmd[2]
      .. " <cmd>lua require('core.terminal')._exec_toggle('"
      .. ft_cmd[3]
      .. "')<CR>"
    local command = table.concat(vim.tbl_flatten { "autocmd", { "FileType", ft_cmd[1], cmd } }, " ")
    vim.cmd(command)
    lvim.builtin.which_key.mappings[ft_cmd[2]] = ft_cmd[4]
  end
  vim.cmd "augroup END"

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

return M
