local M = {}

M.config = function()
  lvim.builtin.indentlines.opts = {
    enabled = true,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
      "help",
      "startify",
      "dashboard",
      "lazy",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "text",
    },
    char = lvim.icons.ui.LineLeft,
    context_char = lvim.icons.ui.LineLeft,
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = true,
    show_current_context = true,
  }
  lvim.builtin.indentlines = require("lvim.core.builtins").add_completion "indentlines"
end

M.setup = function()
  local status_ok, indent_blankline = pcall(reload, "indent_blankline")
  if not status_ok then
    return
  end

  indent_blankline.setup(lvim.builtin.indentlines.opts)
end

return M
