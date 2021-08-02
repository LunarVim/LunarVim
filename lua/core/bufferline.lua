lvim.builtin.bufferline = {
  keymap = {
    values = {
      normal_mode = {
        { "<S-l>", ":BufferNext<CR>" },
        { "<S-h>", ":BufferPrevious<CR>" },
      },
    },
    opts = {
      normal_mode = { noremap = true, silent = true },
    },
  },
}

local keymap = require "utils.keymap"
keymap.load(lvim.builtin.bufferline.keymap.values, lvim.builtin.bufferline.keymap.opts)
