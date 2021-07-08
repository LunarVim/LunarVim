require "default-config"
require "keymappings"
vim.cmd("luafile " .. CONFIG_PATH .. "/lv-config.lua")
require "settings"
require "plugins"
require "lv-utils"
require "lv-treesitter"
if O.plugin.dashboard.active then
  require("lv-dashboard").config()
end
require "lsp"
if O.lang.emmet.active then
  require "lsp.emmet-ls"
end
if O.lang.tailwindcss.active then
  require "lsp.tailwindcss-ls"
end
if O.lang.rust.active then
  require "lsp.rust-ls"
end
