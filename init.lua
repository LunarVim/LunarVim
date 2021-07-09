require "default-config"
require "keymappings"
vim.cmd("luafile " .. CONFIG_PATH .. "/lv-config.lua")
require "settings"
require "plugins"
vim.g.colors_name = O.colorscheme -- Colorscheme must get called after plugins are loaded or it will break new installs.
require "lv-utils"
require "lv-treesitter"
if O.plugin.dashboard.active then
  require("lv-dashboard").config()
end
-- TODO these gues need to be in language files
-- require "lsp"
-- if O.lang.emmet.active then
--   require "lsp.emmet-ls"
-- end
-- if O.lang.tailwindcss.active then
--   require "lsp.tailwind
