local keymap = require "keymappings.keymap"
local default_keys = require "keymappings.preset.default"
local core_keys = require "keymappings.preset.core"
local lsp_keys = require "keymappings.preset.lsp"

-- Set leader
if lvim.leader == " " or lvim.leader == "space" then
  vim.g.mapleader = " "
else
  vim.g.mapleader = lvim.leader
end

-- Set default keys
keymap.set_group("n", default_keys.normal_mode)
keymap.set_group("i", default_keys.insert_mode)
keymap.set_group("v", default_keys.visual_mode)
keymap.set_group("x", default_keys.visual_block_mode)
keymap.set_group("t", default_keys.term_mode)

-- Set core plugins specific keys
keymap.set_group("i", core_keys.compe.insert_mode)
keymap.set_group("s", core_keys.compe.s_mode)
keymap.set_group("n", core_keys.telescope.normal_mode)
keymap.set_group("n", core_keys.bufferline.normal_mode)

-- Set lsp
keymap.set_group("n", lsp_keys.normal_mode)

-- Set custom keymap
-- Currently support normal, insert, visual, and visual block mode
local t = {
  normal_mode = "n",
  insert_mode = "i",
  visual_mode = "v",
  visual_block_mode = "x",
}
for mode, val in pairs(lvim.keys) do
  if t[mode] then
    keymap.set_group(t[mode], val)
  end
end
-- keymap.set_group("n", lvim.keys.normal_mode)
-- keymap.set_group("i", lvim.keys.insert_mode)
-- keymap.set_group("v", lvim.keys.visual_mode)
-- keymap.set_group("x", lvim.keys.visual_block_mode)
