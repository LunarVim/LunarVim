local M = {
  defaults = {
    active = true,
    on_config_done = nil,
    keymap = {
      normal_mode = {
        ["<S-l>"] = ":BufferNext<CR>",
        ["<S-h>"] = ":BufferPrevious<CR>",
      },
    },
  },
}

function M:setup(config)
  config:merge(self.defaults)
end

function M:config()
  local keymap = require "keymappings"
  keymap.append_to_defaults(lvim.builtins.bufferline.keymap)

  if lvim.builtins.bufferline.on_config_done then
    lvim.builtins.bufferline.on_config_done()
  end
end

return M
