local M = {
  defaults = {
    active = true,
    on_config_done = nil,
    config = {
      map_complete = vim.bo.filetype ~= "tex",
      check_ts = true,
      ts_config = {
        java = false,
      },
    },
  },
}

function M:setup(config)
  config:merge(self.defaults)
end

function M:configure()
  -- skip it, if you use another global object
  _G.MUtils = {}
  local autopairs = require "nvim-autopairs"
  local Rule = require "nvim-autopairs.rule"
  local cond = require "nvim-autopairs.conds"

  autopairs.setup {
    check_ts = lvim.builtins.autopairs.config.check_ts,
    ts_config = lvim.builtins.autopairs.config.ts_config,
  }

  -- vim.g.completion_confirm_key = ""

  autopairs.add_rule(Rule("$$", "$$", "tex"))
  autopairs.add_rules {
    Rule("$", "$", { "tex", "latex" }) -- don't add a pair if the next character is %
      :with_pair(cond.not_after_regex_check "%%") -- don't add a pair if  the previous character is xxx
      :with_pair(cond.not_before_regex_check("xxx", 3)) -- don't move right when repeat character
      :with_move(cond.none()) -- don't delete if the next character is xx
      :with_del(cond.not_after_regex_check "xx") -- disable  add newline when press <cr>
      :with_cr(cond.none()),
  }
  autopairs.add_rules {
    Rule("$$", "$$", "tex"):with_pair(function(opts)
      print(vim.inspect(opts))
      if opts.line == "aa $$" then
        -- don't add pair on that line
        return false
      end
    end),
  }

  if package.loaded["cmp"] then
    require("nvim-autopairs.completion.cmp").setup {
      map_cr = true, --  map <CR> on insert mode
      map_complete = true, -- it will auto insert `(` after select function or method item
      auto_select = true, -- automatically select the first item
    }
  end

  require("nvim-treesitter.configs").setup { autopairs = { enable = true } }

  local ts_conds = require "nvim-autopairs.ts-conds"

  -- TODO: can these rules be safely added from "config.lua" ?
  -- press % => %% is only inside comment or string
  autopairs.add_rules {
    Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
  }

  if lvim.builtins.autopairs.on_config_done then
    lvim.builtins.autopairs.on_config_done(autopairs)
  end
end

return M
