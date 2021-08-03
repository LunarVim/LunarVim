vim.api.nvim_command "hi clear"
if vim.fn.exists "syntax_on" then
  vim.api.nvim_command "syntax reset"
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "spacegray"

local util = require "spacegray.util"
Config = require "spacegray.config"
C = require "spacegray.palette"

local async
async = vim.loop.new_async(vim.schedule_wrap(function()
  local skeletons = {}
  for _, skeleton in ipairs(skeletons) do
    util.initialise(skeleton)
  end

  async:close()
end))

local highlights = require "spacegray.highlights"
local Treesitter = require "spacegray.Treesitter"
local markdown = require "spacegray.markdown"
local Whichkey = require "spacegray.Whichkey"
local Git = require "spacegray.Git"
local LSP = require "spacegray.LSP"

local skeletons = {
  highlights,
  Treesitter,
  markdown,
  Whichkey,
  Git,
  LSP,
}

for _, skeleton in ipairs(skeletons) do
  util.initialise(skeleton)
end

async:send()
