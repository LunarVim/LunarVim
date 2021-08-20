local conditions = require "core.lualine.conditions"
local colors = require "core.lualine.colors"

return {
  vi_mode = {
    function()
      return " "
    end,
    left_padding = 0,
    right_padding = 0,
    condition = conditions.hide_in_width,
  },
  branch = {
    "branch",
    icon = " ",
    condition = function()
      return conditions.hide_in_width() and conditions.check_git_workspace()
    end,
  },
  diff = {
    "diff",
    symbols = { added = "  ", modified = "柳", removed = " " },
    color_added = { fg = colors.green },
    color_modified = { fg = colors.yellow },
    color_removed = { fg = colors.red },
    condition = conditions.hide_in_width,
  },
  python_env = {
    function()
      local utils = require "core.lualine.utils"
      if vim.bo.filetype == "python" then
        local venv = os.getenv "CONDA_DEFAULT_ENV"
        if venv then
          return string.format("  (%s)", utils.env_cleanup(venv))
        end
        venv = os.getenv "VIRTUAL_ENV"
        if venv then
          return string.format("  (%s)", utils.env_cleanup(venv))
        end
        return ""
      end
      return ""
    end,
    color = { fg = colors.green },
    condition = conditions.hide_in_width,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_lsp" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    condition = conditions.hide_in_width,
  },
  treesitter = {
    function()
      if next(vim.treesitter.highlighter.active) then
        return "  "
      end
      return ""
    end,
    color = { fg = colors.green },
    condition = conditions.hide_in_width,
  },
  lsp = {
    function(msg)
      msg = msg or "LSP Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      local utils = require "lsp.utils"
      local active_client = utils.get_active_client_by_ft(buf_ft)
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end
      vim.list_extend(buf_client_names, active_client or {})

      -- add formatter
      local formatters = require "lsp.null-ls.formatters"
      local supported_formatters = formatters.list_supported_names(buf_ft)
      vim.list_extend(buf_client_names, supported_formatters or {})

      -- add linter
      local linters = require "lsp.null-ls.linters"
      local supported_linters = linters.list_supported_names(buf_ft)
      vim.list_extend(buf_client_names, supported_linters or {})

      return table.concat(buf_client_names, ", ")
    end,
    condition = conditions.hide_in_width,
    icon = " ",
    color = { gui = "bold" },
  },
  location = { "location", condition = conditions.hide_in_width },
  progress = { "progress", condition = conditions.hide_in_width },
  spaces = {
    function()
      local label = "Spaces: "
      if not vim.api.nvim_buf_get_option(0, "expandtab") then
        label = "Tab size: "
      end
      return label .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
    end,
    condition = conditions.hide_in_width,
  },
  encoding = {
    "o:encoding",
    upper = true,
    condition = conditions.hide_in_width,
  },
  filetype = { "filetype", condition = conditions.hide_in_width },
  scrollbar = {
    function()
      local current_line = vim.fn.line "."
      local total_lines = vim.fn.line "$"
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local index
      local line_no_fraction = current_line / total_lines
      index = vim.fn.float2nr(line_no_fraction * #chars)
      if index == 0 then
        index = 1
      end
      return chars[index]
    end,
    color = { fg = colors.yellow, bg = colors.bg },
    left_padding = 0,
    right_padding = 0,
  },
}
