-- {{{ Bootstrap
local home_dir = vim.loop.os_homedir()

vim.opt.rtp:append(home_dir .. "/.local/share/lunarvim/lvim")

vim.opt.rtp:remove(home_dir .. "/.config/nvim")
vim.opt.rtp:remove(home_dir .. "/.config/nvim/after")
vim.opt.rtp:append(home_dir .. "/.config/lvim")
vim.opt.rtp:append(home_dir .. "/.config/lvim/after")

vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site")
vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site/after")
vim.opt.rtp:append(home_dir .. "/.local/share/lunarvim/site")
vim.opt.rtp:append(home_dir .. "/.local/share/lunarvim/site/after")

-- TODO: we need something like this: vim.opt.packpath = vim.opt.rtp
vim.cmd [[let &packpath = &runtimepath]]
-- }}}

local config = require "config"
config:init()
config:load()

local plugins = require "plugins"
local plugin_loader = require("plugin-loader").init()
plugin_loader:load { plugins, lvim.plugins }

vim.g.colors_name = lvim.colorscheme -- Colorscheme must get called after plugins are loaded or it will break new installs.
vim.cmd("colorscheme " .. lvim.colorscheme)

local utils = require "utils"
utils.toggle_autoformat()
local commands = require "core.commands"
commands.load(commands.defaults)

require("lsp").config()

local null_status_ok, null_ls = pcall(require, "null-ls")
if null_status_ok then
  null_ls.config {}
  require("lspconfig")["null-ls"].setup(lvim.lsp.null_ls.setup)
end

local lsp_settings_status_ok, lsp_settings = pcall(require, "nlspsettings")
if lsp_settings_status_ok then
  lsp_settings.setup {
    config_home = os.getenv "HOME" .. "/.config/lvim/lsp-settings",
  }
end

require("keymappings").setup()

-- TODO: these guys need to be in language files
-- if lvim.lang.emmet.active then
--   require "lsp.emmet-ls"
-- end
-- if lvim.lang.tailwindcss.active then
--   require "lsp.tailwind
