-- {{{ Bootstrap
local home_dir = vim.loop.os_homedir()

vim.opt.rtp:append(home_dir .. "/.local/share/lunarvim/lvim")

vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site")
vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site/after")
vim.opt.rtp:prepend(home_dir .. "/.local/share/lunarvim/site")
vim.opt.rtp:append(home_dir .. "/.local/share/lunarvim/site/after")

vim.opt.rtp:remove(home_dir .. "/.config/nvim")
vim.opt.rtp:remove(home_dir .. "/.config/nvim/after")
vim.opt.rtp:prepend(home_dir .. "/.config/lvim")
vim.opt.rtp:append(home_dir .. "/.config/lvim/after")

-- TODO: we need something like this: vim.opt.packpath = vim.opt.rtp
vim.cmd [[let &packpath = &runtimepath]]
-- }}}

_G.PLENARY_DEBUG = false -- Plenary destroys cache with this undocumented flag set to true by default
require("impatient").enable_profile()

-- GLOBAL configuration
-- This varibale is required as packer cannot capture variables using string.dump
lvim = {}
CONFIG_PATH = home_dir .. "/.local/share/lunarvim/lvim"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"
USER = vim.fn.expand "$USER"

require "main"()

