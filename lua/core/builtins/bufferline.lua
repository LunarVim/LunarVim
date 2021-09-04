local M = {
  defaults = {
    active = true,
    on_config_done = nil,
    keymap = {
      values = {
        normal_mode = {
          ["<S-l>"] = "<cmd>BufferNext<CR>",
          ["<S-h>"] = "<cmd>BufferPrevious<CR>",
        },
      },
      opts = {
        normal_mode = { noremap = true, silent = true },
      },
    },
  },
}

function M:setup(config)
  config:merge(self.defaults)
end

function M:config()
  local keymap = require "core.service.keymap"
  keymap.load(lvim.builtins.bufferline.keymap.values, lvim.builtins.bufferline.keymap.opts)

  if lvim.builtins.bufferline.on_config_done then
    lvim.builtins.bufferline.on_config_done()
  end
end

return M
