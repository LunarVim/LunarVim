local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"
local base_dir = os.getenv "LUNARVIM_RUNTIME_DIR" .. path_sep .. "lvim"
local tests_dir = base_dir .. path_sep .. "tests"

vim.opt.rtp = { base_dir, tests_dir, os.getenv "VIMRUNTIME" }

vim.opt.swapfile = false

-- load helper functions before any other plugin to avoid name-collisions
pcall(require, "tests.helpers")

require("lvim.bootstrap"):init()
