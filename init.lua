local base_dir = vim.env.LUNARVIM_BASE_DIR
  or (function()
    local init_path = debug.getinfo(1, "S").source
    return init_path:sub(2):match("(.*[/\\])"):sub(1, -2)
  end)()

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:append(base_dir)
end

require("lvim.bootstrap"):init(base_dir)

require("lvim.config"):load()

local plugins = require "lvim.plugins"

require("lvim.plugin-loader").load { plugins, lvim.plugins }

require("lvim.core.theme").setup()

local Log = require "lvim.core.log"
Log:debug "Starting LunarVim"

local commands = require "lvim.core.commands"
commands.load(commands.defaults)

require("lvim.lsp").setup()

vim.cmd("set foldmethod=indent")
vim.cmd("set foldlevel=0")
vim.cmd("set ai")

--stop auto indent
vim.cmd("set indentexpr=")

--zoom in and out
vim.cmd("noremap z2 <c-w>_ \\| <c-w>\\|")
vim.cmd("noremap z1 <c-w>=")

vim.cmd [[
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set backspace=indent,eol,start
    set expandtab
    set autoindent
    set smarttab
    set encoding=utf-8
    set incsearch 
    set hlsearch
]]
