--- Goyo layer
-- @module l.goyo

local plug = require("c.plug")
local keybind = require("c.keybind")
local mode = require("c.edit_mode")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("junegunn/goyo.vim")
end

--- Configures vim and plugins for this layer
function layer.init_config()
  keybind.bind_command(mode.NORMAL, "<leader>z", ":Goyo<CR>", { noremap = true, silent = true }, "zen")
end

return layer
