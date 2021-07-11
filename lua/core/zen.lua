local M = {}

M.opts = {
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

local status_ok, zen_mode = pcall(require, "zen-mode")
if not status_ok then
  return
end

M.config = function()
  require('lv-utils').fetch_overrides(O.plugin.zen, M.opts)
  zen_mode.setup(O.plugin.zen)
end
return M
