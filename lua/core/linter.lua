local M = {}

M.setup = function()
  if O.lint_on_save then
    require("lv-utils").define_augroups {
      autolint = {
        {
          "BufWritePost",
          "<buffer>",
          ":silent lua require('lint').try_lint()",
        },
        {
          "BufEnter",
          "<buffer>",
          ":silent lua require('lint').try_lint()",
        },
      },
    }
  end
end

local status_ok, _ = pcall(require, "lint")
if not status_ok then
  return
end

if not O.lint_on_save then
  vim.cmd [[if exists('#autolint#BufWritePost')
	:autocmd! autolint
	endif]]
end

return M
