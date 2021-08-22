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
  -- skip it, if you use another global object
  _G.MUtils = {}
  local autopairs = require "nvim-autopairs"
  local Rule = require "nvim-autopairs.rule"

  vim.g.completion_confirm_key = ""
  MUtils.completion_confirm = function()
    if vim.fn.pumvisible() ~= 0 then
      if vim.fn.complete_info()["selected"] ~= -1 then
        return vim.fn["compe#confirm"](autopairs.esc "<cr>")
      else
        return autopairs.esc "<cr>"
      end
    else
      return autopairs.autopairs_cr()
    end
  end

  if package.loaded["compe"] then
    require("nvim-autopairs.completion.compe").setup {
      map_cr = lvim.builtin.autopairs.map_cr,
      map_complete = lvim.builtin.autopairs.map_complete,
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
