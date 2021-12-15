local init_path = debug.getinfo(1, "S").source:sub(2)
local base_dir = init_path:match("(.*[/\\])"):sub(1, -2)

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:append(base_dir)
end

require "lvim.utils.headless_fix"

-- This is only defined when updating using `lvim --update`
---@diagnostic disable-next-line: undefined-field
local updating = _G.__lvim_updating or false

require("lvim.bootstrap"):init(base_dir, updating)

-- prevents setup while updater callbacks complete
if updating then
  return
end

require("lvim.config"):load()

local plugins = require "lvim.plugins"
require("lvim.plugin-loader").load { plugins, lvim.plugins }

local Log = require "lvim.core.log"
Log:debug "Starting LunarVim"

local commands = require "lvim.core.commands"
commands.load(commands.defaults)

require("lvim.lsp").setup()
