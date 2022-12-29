local M = {}

local builtins = {
  "lvim.core.theme",
  "lvim.core.which-key",
  "lvim.core.gitsigns",
  "lvim.core.cmp",
  "lvim.core.dap",
  "lvim.core.terminal",
  "lvim.core.telescope",
  "lvim.core.treesitter",
  "lvim.core.nvimtree",
  "lvim.core.lir",
  "lvim.core.illuminate",
  "lvim.core.indentlines",
  "lvim.core.breadcrumbs",
  "lvim.core.project",
  "lvim.core.bufferline",
  "lvim.core.autopairs",
  "lvim.core.comment",
  "lvim.core.lualine",
  "lvim.core.alpha",
  "lvim.core.noice",
  "lvim.core.mason",
  "lvim.core.nvimsurround",
  "lvim.core.harpoon",
  "lvim.core.hop",
  "lvim.core.neogit",
  "lvim.core.neoscroll",
  "lvim.core.neotree",
  "lvim.core.numb",
  "lvim.core.sessionmanager",
  "lvim.core.symbolsoutline",
  "lvim.core.trouble",
  "lvim.core.undotree",
  "lvim.core.harpoon",
  "lvim.core.diffview"

}

function M.config(config)
  for _, builtin_path in ipairs(builtins) do
    local builtin = reload(builtin_path)

    builtin.config(config)
  end
end

return M
