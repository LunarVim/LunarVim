local M = {}

function M.config()
  lvim.builtin.autopairs = {
    active = true,
    ---@usage  map <CR> on insert mode
    map_cr = true,
    ---@usage it will auto insert  after select function or method item,
    map_complete = map_complete_optional,
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
  local Log = require "core.log"
  local npairs = require "nvim-autopairs"
  local Rule = require "nvim-autopairs.rule"

  vim.g.completion_confirm_key = ""
  MUtils.completion_confirm = function()
    if vim.fn.pumvisible() ~= 0 then
      if vim.fn.complete_info()["selected"] ~= -1 then
        return vim.fn["compe#confirm"](npairs.esc "<cr>")
      else
        return npairs.esc "<cr>"
      end
    else
      return npairs.autopairs_cr()
    end
  end

  if package.loaded["compe"] then
    local map_complete_optional = vim.bo.filetype ~= "tex"
    require("nvim-autopairs.completion.compe").setup {
      map_cr = lvim.builtin.autopairs.map_cr,
      map_complete = lvim.builtin.autopairs.map_complete,
    }
  end

  npairs.setup {
    check_ts = lvim.builtin.autopairs.check_ts,
    ts_config = lvim.builtin.autopairs.ts_config,
  }

  require("nvim-treesitter.configs").setup { autopairs = { enable = true } }

  local ts_conds = require "nvim-autopairs.ts-conds"

  -- TODO: can these rules be safely added from "config.lua" ?
  -- press % => %% is only inside comment or string
  npairs.add_rules {
    Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
  }
end

return M
