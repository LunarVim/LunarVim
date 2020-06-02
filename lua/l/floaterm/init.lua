--- Floaterm layer
-- @module l.floaterm

local plug = require("c.plug")
local kb = require("c.keybind")
local mode = require("c.edit_mode")
local autocmd = require("c.autocmd")
local util = require("c.util")

local vg = vim.g

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("voldikss/vim-floaterm")
end

--- Configures vim and plugins for this layer
function layer.init_config()

  vg.floaterm_keymap_toggle =  '<F1>'
  vg.floaterm_keymap_next   =  '<F2>'
  vg.floaterm_keymap_prev   =  '<F3>'
  vg.floaterm_keymap_new    =  '<F4>'

  -- Floaterm
  vg.floaterm_gitcommit   = 'floaterm'
  vg.floaterm_autoinsert  = 1
  vg.floaterm_width       = 0.8
  vg.floaterm_height      = 0.8
  vg.floaterm_wintitle    = 0
  vg.floaterm_autoclose   = 1

  local default_opts = { noremap = true, silent = true }
  kb.set_group_name("<leader>t", "terminal")
  kb.bind_command(mode.NORMAL, "<leader>t;", ":FloatermNew --wintype=popup --height=6<CR>", default_opts, "terminal")
  kb.bind_command(mode.NORMAL, "<leader>tf", ":FloatermNew fzf<CR>", default_opts, "fzf")
  kb.bind_command(mode.NORMAL, "<leader>tg", ":FloatermNew lazygit<CR>", default_opts, "git")
  kb.bind_command(mode.NORMAL, "<leader>td", ":FloatermNew lazydocker<CR>", default_opts, "docker")
  kb.bind_command(mode.NORMAL, "<leader>tn", ":FloatermNew node<CR>", default_opts, "node")
  kb.bind_command(mode.NORMAL, "<leader>tN", ":FloatermNew nnn<CR>", default_opts, "nnn")
  kb.bind_command(mode.NORMAL, "<leader>tp", ":FloatermNew python<CR>", default_opts, "python")
  kb.bind_command(mode.NORMAL, "<leader>tr", ":FloatermNew ranger<CR>", default_opts, "ranger")
  kb.bind_command(mode.NORMAL, "<leader>tt", ":FloatermToggle<CR>", default_opts, "toggle")
  kb.bind_command(mode.NORMAL, "<leader>ty", ":FloatermNew ytop<CR>", default_opts, "ytop")
  kb.bind_command(mode.NORMAL, "<leader>ts", ":FloatermNew ncdu<CR>", default_opts, "ncdu")
end


return layer
