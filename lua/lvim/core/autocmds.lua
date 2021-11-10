local M = {}
local Log = require "lvim.core.log"

--- Load the default set of autogroups and autocommands.
function M.load_augroups()
  local user_config_file = vim.fn.resolve(require("lvim.config"):get_user_config_path())

  return {
    _general_settings = {
      { "FileType", "qf,help,man", "nnoremap <silent> <buffer> q :close<CR>" },
      {
        "TextYankPost",
        "*",
        "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
      },
      {
        "BufWinEnter",
        "dashboard",
        "setlocal cursorline signcolumn=yes cursorcolumn number",
      },
      { "BufWritePost", user_config_file, "lua require('lvim.config'):reload()" },
      { "FileType", "qf", "set nobuflisted" },
      -- { "VimLeavePre", "*", "set title set titleold=" },
    },
    _formatoptions = {
      {
        "BufWinEnter,BufRead,BufNewFile",
        "*",
        "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
      },
    },
    _filetypechanges = {
      { "BufWinEnter", ".tf", "setlocal filetype=terraform" },
      { "BufRead", "*.tf", "setlocal filetype=terraform" },
      { "BufNewFile", "*.tf", "setlocal filetype=terraform" },
      { "BufWinEnter", ".zsh", "setlocal filetype=sh" },
      { "BufRead", "*.zsh", "setlocal filetype=sh" },
      { "BufNewFile", "*.zsh", "setlocal filetype=sh" },
    },
    _git = {
      { "FileType", "gitcommit", "setlocal wrap" },
      { "FileType", "gitcommit", "setlocal spell" },
    },
    _markdown = {
      { "FileType", "markdown", "setlocal wrap" },
      { "FileType", "markdown", "setlocal spell" },
    },
    _buffer_bindings = {
      { "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
    },
    _auto_resize = {
      -- will cause split windows to be resized evenly if main window is resized
      { "VimResized", "*", "tabdo wincmd =" },
    },
    _general_lsp = {
      { "FileType", "lspinfo,lsp-installer,null-ls-info", "nnoremap <silent> <buffer> q :close<CR>" },
    },
    custom_groups = {},
  }
end

function M.enable_format_on_save(opts)
  opts = opts or {}
  opts.pattern = opts.pattern or "*"
  opts.timeout_ms = opts.timeout_ms or 1000
  local fmd_cmd = string.format(":silent lua vim.lsp.buf.formatting_sync({}, %s)", opts.timeout_ms)
  M.define_augroups {
    format_on_save = { { "BufWritePre", opts.pattern, fmd_cmd } },
  }
  Log:debug "format-on-save set to true"
end

function M.disable_format_on_save()
  M.remove_augroup "format_on_save"
  Log:debug "format-on-save set to false"
end

function M.configure_format_on_save()
  if lvim.format_on_save then
    if vim.fn.exists "#format_on_save" == 1 then
      M.remove_augroup "format_on_save"
      Log:debug "reloading format-on-save configuration"
    end
    local opts = { pattern = lvim.format_on_save_pattern, timeout_ms = lvim.format_on_save_timeout }
    M.enable_format_on_save(opts)
  else
    M.disable_format_on_save()
  end
end

function M.toggle_format_on_save()
  if vim.fn.exists "#format_on_save" == 0 then
    local opts = { pattern = lvim.format_on_save_pattern, timeout_ms = lvim.format_on_save_timeout }
    M.enable_format_on_save(opts)
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

function M.define_augroups(definitions) -- {{{1
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

return M
