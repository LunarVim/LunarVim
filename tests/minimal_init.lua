local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"

vim.opt.rtp:append(os.getenv "LUNARVIM_RUNTIME_DIR" .. path_sep .. "lvim")

require("bootstrap"):init()

local config = require "config"
-- config:init()
config:load()
