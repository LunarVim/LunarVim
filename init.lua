local init_path = debug.getinfo(1, "S").source:sub(2)
local base_dir = init_path:match("(.*[/\\])"):sub(1, -2)

if not vim.tbl_contains(vim.opt.rtp:get(), base_dir) then
  vim.opt.rtp:append(base_dir)
end

reload = require("lvim.utils.reload").reload

reload("lvim.bootstrap"):init(base_dir)

reload("lvim.config"):load()

local plugins = reload "lvim.plugins"

reload("lvim.plugin-loader").load { plugins, lvim.plugins }

local Log = reload "lvim.core.log"
Log:debug "Starting LunarVim"

local commands = reload "lvim.core.commands"
commands.load(commands.defaults)

reload("lvim.lsp").setup()
