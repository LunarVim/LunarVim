local lv_utils = {}

function lv_utils.reload_lv_config()
  vim.cmd "source ~/.config/nvim/lv-config.lua"
  vim.cmd "source ~/.config/nvim/lua/plugins.lua"
  vim.cmd "source ~/.config/nvim/lua/lv-neoformat/init.lua"
  vim.cmd ":PackerCompile"
  vim.cmd ":PackerInstall"
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

lv_utils.define_augroups {

  _user_autocommands = O.user_autocommands,
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
    { "VimLeavePre", "*", "set title set titleold=" },
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
    { "VimResized ", "*", "wincmd =" },
  },
  -- _mode_switching = {
  --   -- will switch between absolute and relative line numbers depending on mode
  --   {'InsertEnter', '*', 'if &relativenumber | let g:ms_relativenumberoff = 1 | setlocal number norelativenumber | endif'},
  --   {'InsertLeave', '*', 'if exists("g:ms_relativenumberoff") | setlocal relativenumber | endif'},
  --   {'InsertEnter', '*', 'if &cursorline | let g:ms_cursorlineoff = 1 | setlocal nocursorline | endif'},
  --   {'InsertLeave', '*', 'if exists("g:ms_cursorlineoff") | setlocal cursorline | endif'},
  -- },
}

return lv_utils

-- TODO find a new home for these autocommands
