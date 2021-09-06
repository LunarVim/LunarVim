local M = {}

function M.config()
  lvim.builtin.autopairs = {
    active = true,
    on_config_done = nil,
    ---@usage  map <CR> on insert mode
    map_cr = true,
    ---@usage auto insert after select function or method item
    -- NOTE: This should be wrapped into a function so that it is re-evaluated when opening new files
    map_complete = vim.bo.filetype ~= "tex",
    ---@usage check treesitter
    check_ts = true,
    ts_config = {
      lua = { "string" },
      javascript = { "template_string" },
      java = false,
    },
  }
end

M.setup = function()
  local autopairs = require "nvim-autopairs"
  local Rule = require "nvim-autopairs.rule"

  -- vim.g.completion_confirm_key = ""

  if package.loaded["cmp"] then
    require("nvim-autopairs.completion.cmp").setup {
      map_cr = true, --  map <CR> on insert mode
      map_complete = true, -- it will auto insert `(` after select function or method item
      auto_select = true, -- automatically select the first item
    }
  end

  autopairs.setup {
    check_ts = lvim.builtin.autopairs.check_ts,
    ts_config = lvim.builtin.autopairs.ts_config,
  }

  require("nvim-treesitter.configs").setup { autopairs = { enable = true } }

  local ts_conds = require "nvim-autopairs.ts-conds"

  -- TODO: can these rules be safely added from "config.lua" ?
  -- press % => %% is only inside comment or string
  autopairs.add_rules {
    Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
  }

  if lvim.builtin.autopairs.on_config_done then
    lvim.builtin.autopairs.on_config_done(autopairs)
  end
end

return M
