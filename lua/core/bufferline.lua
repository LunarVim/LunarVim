lvim.builtin.bufferline = {
  active = true,
  keymap = {
    normal_mode = {
      ["<S-l>"] = ":BufferNext<CR>",
      ["<S-h>"] = ":BufferPrevious<CR>",
    },
  },
}

local keymap = require "keymappings"
keymap.append_to_defaults(lvim.builtin.bufferline.keymap)
