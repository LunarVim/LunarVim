local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"
local base_dir = os.getenv "LUNARVIM_RUNTIME_DIR" .. path_sep .. "lvim"
local tests_dir = base_dir .. path_sep .. "tests"

vim.opt.rtp:append(tests_dir)
vim.opt.rtp:append(base_dir)

require("lvim.bootstrap"):init(base_dir)

-- NOTE: careful about name collisions
-- see https://github.com/nvim-lualine/lualine.nvim/pull/621
require "tests.lvim.helpers"
