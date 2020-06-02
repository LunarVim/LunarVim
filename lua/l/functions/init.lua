--- Functions layer
-- @module l.functions

local plug = require("c.plug")
local bind_cmd = require("c.keybind").bind_command
local mode = require("c.edit_mode")
local autocmd = require("c.autocmd")
local util = require("c.util")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins() end

--- Configures vim and plugins for this layer
function layer.init_config()
  -- TODO: Confirm this actually work, I don't believe they do just yet
  -- Turn spellcheck on for markdown files  
  autocmd.bind("BufNewFile,BufRead *.md", function()
    vim.wo.spell = true
  end)
end

return layer
