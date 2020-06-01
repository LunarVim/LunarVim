--- Goyo layer
-- @module l.goyo

local plug = require("c.plug")
local bind_cmd = require("c.keybind").bind_command
local mode = require("c.edit_mode")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("junegunn/goyo.vim")
end

--- Configures vim and plugins for this layer
function layer.init_config()
  bind_cmd(mode.NORMAL, "<silent> <leader>z", ":Goyo<CR>")
end

return layer
