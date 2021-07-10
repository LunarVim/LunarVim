require "default-config"
require "keymappings"
require "lv-distrib"
local status_ok, _ = pcall(vim.cmd, "luafile " .. CONFIG_PATH .. "/lv-config.lua")
if not status_ok then
  print "something is wrong with your lv-config"
end
require "plugins"
vim.g.colors_name = O.colorscheme -- Colorscheme must get called after plugins are loaded or it will break new installs.
require "settings"
require "lv-utils"
require "lv-treesitter"

-- TODO: these guys need to be in language files
-- require "lsp"
-- if O.lang.emmet.active then
--   require "lsp.emmet-ls"
-- end
-- if O.lang.tailwindcss.active then
--   require "lsp.tailwind
