--- Layer management
-- @module layers.settings.layer_man

local command = require("c.command")
local file = require("c.file")

local layer_man = {}

local function edit_layer(layer_name)
  -- TODO: Support $XDG_CONFIG_HOME?
  local layer_dir = file.get_home_dir() .. "/.config/nvim/lua/l/" .. layer_name

  if not file.is_dir(layer_dir) then
    file.mkdir(layer_dir, false)
  end

  vim.cmd("edit " .. layer_dir)
end

function layer_man.init_config()
  command.make_command("CEditLayer", edit_layer, 1)
end

return layer_man
