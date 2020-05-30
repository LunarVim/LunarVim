--- Edit modes
-- @module c.edit_mode

local edit_mode = {}

--- Normal mode
edit_mode.NORMAL = {
  map_prefix = "n",
}

--- Visual mode
edit_mode.VISUAL = {
  map_prefix = "x",
}

--- Select mode
edit_mode.SELECT = {
  map_prefix = "s",
}

--- Not a real mode, just for the vmap/vnoremap commands
edit_mode.VISUAL_SELECT = {
  map_prefix = "v",
}

--- Insert mode
edit_mode.INSERT = {
  map_prefix = "i",
}

--- Command mode
edit_mode.COMMAND = {
  map_prefix = "c",
}

--- Operator pending mode
edit_mode.OPERATOR_PENDING = {
  map_prefix = "o",
}

--- Terminal mode
edit_mode.TERMINAL = {
  map_prefix = "t",
}

return edit_mode
