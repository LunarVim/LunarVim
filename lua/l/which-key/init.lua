--- Which-Key layer
-- @module l.which-key

local plug = require("c.plug")
local keybind = require("c.keybind")
local mode = require("c.edit_mode")
local autocmd = require("c.autocmd")
local util = require("c.util")

local vg = vim.g      -- vim (global) variables table
local vo = vim.o      -- vim (global) options table
local api = vim.api   -- exposed vim API for running nvim commands

local layer = {}

local key_map

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("liuchengxu/vim-which-key")
end

--- Configures vim and plugins for this layer
function layer.init_config()
  local leader = vim.api.nvim_get_var("mapleader")

  local function bind_which_key_trigger(trigger)
    local default_opts = { noremap = true, silent = true }
    local cmd_template = "<leader> :<c-u>%s '%s'<CR>"

    local normal_cmd = string.format(cmd_template, ':WhichKey', leader)
    keybind.bind_command(mode.NORMAL, leader, normal_cmd, default_opts)

    local visual_cmd = string.format(cmd_template, ':WhichKeyVisual', leader)
    keybind.bind_command(mode.VISUAL, leader, visual_cmd, default_opts)
  end


  -- Bind leader to show which key
  bind_which_key_trigger(leader)

  -- Register the leader key info dict
  vim.fn["which_key#register"](leader, "g:which_key_map")

  local floatOpts = { col = -2, width = -1 }
  
  vg.which_key_floating_opts = floatOpts  -- Center which key better if floating windows enabled  
  vg.which_key_sep = '→'                  -- Define a separator
  vg.which_key_use_floating_win = false   -- Disable floating windows for which-key

  -- Change the colors if you want
  vim.cmd("highlight default link WhichKey          Operator")
  vim.cmd("highlight default link WhichKeySeperator DiffAdded")
  vim.cmd("highlight default link WhichKeyGroup     Identifier")
  vim.cmd("highlight default link WhichKeyDesc      Function")

  -- Hide status line if which_key guide buffer is open
  autocmd.bind('FileType which_key', function()
    vo.laststatus = 0
    vo.showmode   = false
    vo.ruler      = false
    autocmd.bind('BufLeave <buffer>', function()
      vo.laststatus  = 2
      vo.showmode    = false
      vo.ruler       = true
    end)
  end)
end

return layer
