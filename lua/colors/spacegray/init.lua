vim.api.nvim_command("hi clear")
if vim.fn.exists("syntax_on") then
    vim.api.nvim_command("syntax reset")
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "spacegray"

local util = require("colors.spacegray.util")
Config = require("colors.spacegray.config")
C = require("colors.spacegray.palette")
local highlights = require("colors.spacegray.highlights")
local Treesitter = require("colors.spacegray.Treesitter")
local markdown = require("colors.spacegray.markdown")
local Whichkey = require("colors.spacegray.Whichkey")
local Git = require("colors.spacegray.Git")
local LSP = require("colors.spacegray.LSP")


local skeletons = {
    highlights, Treesitter, markdown, Whichkey, Git, LSP
}

for _, skeleton in ipairs(skeletons) do
    util.initialise(skeleton)
end
