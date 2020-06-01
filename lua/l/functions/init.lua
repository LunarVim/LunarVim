--- Functions layer
-- @module l.functions

local plug = require("c.plug")
local bind_cmd = require("c.keybind").bind_command
local mode = require("c.edit_mode")
local autocmd = require("c.autocmd")
local util = require("c.util")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  -- N/A
end

--- Configures vim and plugins for this layer
-- TODO: Confirm these actually work, I dodn't believe they do yet
function layer.init_config()
  -- Turn spellcheck on for markdown files
  autocmd.bind("BufNewFile,BufRead *.md", function()
    vim.wo.spell = true
  end)

  -- -- Remove trailing whitespaces automatically before save
  -- autocmd.bind("BufWritePre *", function()
  --   vim.call('utils#stripTrailingWhitespaces')
  -- end)
end

return layer
