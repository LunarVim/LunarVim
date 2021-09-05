local M = {}

local defaults = {
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
}

function M:setup(overrides)
  local Config = require "config"
  self.config = Config(defaults)
  self.config:merge(overrides)
end

function M:configure()
  local keymap = require "core.service.keymap"
  local mappings = self.config:get "keymap"
  keymap.load(mappings.values, mappings.opts)

  if self.config:get "on_config_done" then
    self.config:get "on_config_done"()
  end
end

return M
