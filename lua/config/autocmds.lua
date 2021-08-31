local autocmds = {}

function autocmds.setup(config)
  config:extend {
    _general_settings = {
      {
        "Filetype",
        "*",
        "lua require('utils.ft').do_filetype(vim.fn.expand(\"<amatch>\"))",
      },
      {
        "FileType",
        "qf",
        "nnoremap <silent> <buffer> q :q<CR>",
      },
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
      { "BufWritePost", config.path, "lua require('utils').reload_lv_config()" },
      {
        "FileType",
        "qf",
        "set nobuflisted",
      },
      -- { "VimLeavePre", "*", "set title set titleold=" },
    },
    _filetypechanges = {
      { "BufWinEnter", ".tf", "setlocal filetype=terraform" },
      { "BufRead", "*.tf", "setlocal filetype=terraform" },
      { "BufNewFile", "*.tf", "setlocal filetype=terraform" },
      { "BufWinEnter", ".zsh", "setlocal filetype=sh" },
      { "BufRead", "*.zsh", "setlocal filetype=sh" },
      { "BufNewFile", "*.zsh", "setlocal filetype=sh" },
    },
    -- _solidity = {
    --     {'BufWinEnter', '.sol', 'setlocal filetype=solidity'}, {'BufRead', '*.sol', 'setlocal filetype=solidity'},
    --     {'BufNewFile', '*.sol', 'setlocal filetype=solidity'}
    -- },
    -- _gemini = {
    --     {'BufWinEnter', '.gmi', 'setlocal filetype=markdown'}, {'BufRead', '*.gmi', 'setlocal filetype=markdown'},
    --     {'BufNewFile', '*.gmi', 'setlocal filetype=markdown'}
    -- },
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
      { "VimResized", "*", "wincmd =" },
    },
    _packer_compile = {
      -- will run PackerCompile after writing plugins.lua
      { "BufWritePost", "plugins.lua", "PackerCompile" },
    },
    _general_lsp = {
      { "FileType", "lspinfo", "nnoremap <silent> <buffer> q :q<CR>" },
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
    custom_groups = {},
  }
end

return autocmds
