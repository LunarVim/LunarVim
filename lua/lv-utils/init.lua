local lv_utils = {}

-- recursive Print (structure, limit, separator)
local function r_inspect_settings(structure, limit, separator)
  limit = limit or 100 -- default item limit
  separator = separator or "." -- indent string
  if limit < 1 then
    print "ERROR: Item limit reached."
    return limit - 1
  end
  if structure == nil then
    io.write("-- O", separator:sub(2), " = nil\n")
    return limit - 1
  end
  local ts = type(structure)

  if ts == "table" then
    for k, v in pairs(structure) do
      -- replace non alpha keys wih ["key"]
      if tostring(k):match "[^%a_]" then
        k = '["' .. tostring(k) .. '"]'
      end
      limit = r_inspect_settings(v, limit, separator .. "." .. tostring(k))
      if limit < 0 then
        break
      end
    end
    return limit
  end

  if ts == "string" then
    -- escape sequences
    structure = string.format("%q", structure)
  end
  separator = separator:gsub("%.%[", "%[")
  if type(structure) == "function" then
    -- don't print functions
    io.write("-- O", separator:sub(2), " = function ()\n")
  else
    io.write("O", separator:sub(2), " = ", tostring(structure), "\n")
  end
  return limit - 1
end

function lv_utils.generate_settings()
  -- Opens a file in append mode
  local file = io.open("lv-settings.lua", "w")

  -- sets the default output file as test.lua
  io.output(file)

  -- write all `O` related settings to `lv-settings.lua` file
  r_inspect_settings(O, 10000, ".")

  -- closes the open file
  io.close(file)
end

function lv_utils.reload_lv_config()
  vim.cmd "source ~/.config/lvim/lv-config.lua"
  vim.cmd "source ~/.local/share/lvim/lua/plugins.lua"
  vim.cmd "source ~/.local/share/lvim/lua/settings.lua"
  vim.cmd "source ~/.local/share/lvim/lua/core/formatter.lua"
  vim.cmd ":PackerCompile"
  vim.cmd ":PackerInstall"
  -- vim.cmd ":PackerClean"
end

function lv_utils.check_lsp_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true
    end
  end
  return false
end

function lv_utils.add_keymap(mode, opts, keymaps)
  for _, keymap in ipairs(keymaps) do
    vim.api.nvim_set_keymap(mode, keymap[1], keymap[2], opts)
  end
end

function lv_utils.add_keymap_normal_mode(opts, keymaps)
  lv_utils.add_keymap("n", opts, keymaps)
end

function lv_utils.add_keymap_visual_mode(opts, keymaps)
  lv_utils.add_keymap("v", opts, keymaps)
end

function lv_utils.add_keymap_visual_block_mode(opts, keymaps)
  lv_utils.add_keymap("x", opts, keymaps)
end

function lv_utils.add_keymap_insert_mode(opts, keymaps)
  lv_utils.add_keymap("i", opts, keymaps)
end

function lv_utils.add_keymap_term_mode(opts, keymaps)
  lv_utils.add_keymap("t", opts, keymaps)
end

function lv_utils.define_augroups(definitions) -- {{{1
  -- Create autocommand groups based on the passed definitions
  --
  -- The key will be the name of the group, and each definition
  -- within the group should have:
  --    1. Trigger
  --    2. Pattern
  --    3. Text
  -- just like how they would normally be defined from Vim itself
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    vim.cmd "autocmd!"

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
      vim.cmd(command)
    end

    vim.cmd "augroup END"
  end
end

function lv_utils.unrequire(m)
  package.loaded[m] = nil
  _G[m] = nil
end

lv_utils.define_augroups {

  _general_settings = {
    {
      "TextYankPost",
      "*",
      "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
    },
    {
      "BufWinEnter",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    {
      "BufWinEnter",
      "dashboard",
      "setlocal cursorline signcolumn=yes cursorcolumn number",
    },
    {
      "BufRead",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    {
      "BufNewFile",
      "*",
      "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    },
    { "BufWritePost", "lv-config.lua", "lua require('lv-utils').reload_lv_config()" },
    -- { "VimLeavePre", "*", "set title set titleold=" },
  },
  _solidity = {
    { "BufWinEnter", ".tf", "setlocal filetype=hcl" },
    { "BufRead", "*.tf", "setlocal filetype=hcl" },
    { "BufNewFile", "*.tf", "setlocal filetype=hcl" },
  },
  -- _solidity = {
  --     {'BufWinEnter', '.sol', 'setlocal filetype=solidity'}, {'BufRead', '*.sol', 'setlocal filetype=solidity'},
  --     {'BufNewFile', '*.sol', 'setlocal filetype=solidity'}
  -- },
  -- _gemini = {
  --     {'BufWinEnter', '.gmi', 'setlocal filetype=markdown'}, {'BufRead', '*.gmi', 'setlocal filetype=markdown'},
  --     {'BufNewFile', '*.gmi', 'setlocal filetype=markdown'}
  -- },
  _markdown = {
    { "FileType", "markdown", "setlocal wrap" },
    { "FileType", "markdown", "setlocal spell" },
  },
  _buffer_bindings = {
    { "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
  },
  _auto_resize = {
    -- will cause split windows to be resized evenly if main window is resized
    { "VimResized", "*", "wincmd =" },
  },
  _packer_compile = {
    -- will cause split windows to be resized evenly if main window is resized
    { "BufWritePost", "plugins.lua", "PackerCompile" },
  },

  -- _fterm_lazygit = {
  --   -- will cause esc key to exit lazy git
  --   {"TermEnter", "*", "call LazyGitNativation()"}
  -- },
  -- _mode_switching = {
  --   -- will switch between absolute and relative line numbers depending on mode
  --   {'InsertEnter', '*', 'if &relativenumber | let g:ms_relativenumberoff = 1 | setlocal number norelativenumber | endif'},
  --   {'InsertLeave', '*', 'if exists("g:ms_relativenumberoff") | setlocal relativenumber | endif'},
  --   {'InsertEnter', '*', 'if &cursorline | let g:ms_cursorlineoff = 1 | setlocal nocursorline | endif'},
  --   {'InsertLeave', '*', 'if exists("g:ms_cursorlineoff") | setlocal cursorline | endif'},
  -- },
  _user_autocommands = O.user_autocommands,
}

function lv_utils.gsub_args(args)
  if args == nil or type(args) ~= "table" then
    return args
  end
  local buffer_filepath = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
  for i = 1, #args do
    args[i] = string.gsub(args[i], "${FILEPATH}", buffer_filepath)
  end
  return args
end

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
endfunction
]]

return lv_utils

-- TODO: find a new home for these autocommands
