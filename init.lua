require "default-config"
require "keymappings"

local lv_utils = require "lv-utils"
-- Load the user config
lv_utils.load_user_config()

require "plugins"
vim.g.colors_name = O.colorscheme -- Colorscheme must get called after plugins are loaded or it will break new installs.
require "settings"
require "lv-treesitter"

-- TODO: these guys need to be in language files
-- require "lsp"
-- if O.lang.emmet.active then
--   require "lsp.emmet-ls"
-- end
-- if O.lang.tailwindcss.active then
--   require "lsp.tailwind
