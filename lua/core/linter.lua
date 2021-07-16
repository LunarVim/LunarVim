local M = {}

M.setup = function()
  require("lv-utils").define_augroups {
    autolint = {
      {
        "BufWritePost",
        "<buffer>",
        ":lua require('lint').try_lint()",
      },
    },
  }
end

return M
