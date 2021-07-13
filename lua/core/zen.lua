local m = {}

m.packer_config = function()
  return require("lv-utils").adapt_plugin(m, {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    event = "BufRead",
    disable = not O.plugin.zen.active,
  })
end

m.load_defaults = function()
  O.plugin["zen"] = {
    window = {
      backdrop = 1,
      height = 0.85, -- height of the Zen window
      options = {
        signcolumn = "no", -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
        -- cursorline = false, -- disable cursorline
        -- cursorcolumn = false, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      gitsigns = { enabled = false }, -- disables git signs
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  }
end

m.config = function()
  local status_ok, zen_mode = pcall(require, "zen-mode")
  if not status_ok then
    return
  end
  zen_mode.setup(O.plugin.zen)
end

return m
