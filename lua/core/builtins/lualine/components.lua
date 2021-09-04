local conditions = require "core.builtins.lualine.conditions"
local colors = require "core.builtins.lualine.colors"

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

return {
  mode = {
    function()
      return " "
    end,
    left_padding = 0,
    right_padding = 0,
    color = {},
    condition = nil,
  },
  branch = {
    "b:gitsigns_head",
    icon = " ",
    color = { gui = "bold" },
    condition = conditions.hide_in_width,
  },
  filename = {
    "filename",
    color = {},
    condition = nil,
  },
  diff = {
    "diff",
    source = diff_source,
    symbols = { added = "  ", modified = "柳", removed = " " },
    color_added = { fg = colors.green },
    color_modified = { fg = colors.yellow },
    color_removed = { fg = colors.red },
    color = {},
    condition = nil,
  },
  python_env = {
    function()
      local utils = require "core.builtins.lualine.utils"
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
    color = {},
    condition = conditions.hide_in_width,
  },
  treesitter = {
    function()
      local b = vim.api.nvim_get_current_buf()
      if next(vim.treesitter.highlighter.active[b]) then
        return "  "
      end
      return ""
    end,
    color = { fg = colors.green },
    condition = conditions.hide_in_width,
  },
  lsp = {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
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
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require "lsp.null-ls.linters"
      local supported_linters = linters.list_supported_names(buf_ft)
      vim.list_extend(buf_client_names, supported_linters)

      return table.concat(buf_client_names, ", ")
    end,
    icon = " ",
    color = { gui = "bold" },
    condition = conditions.hide_in_width,
  },
  location = { "location", condition = conditions.hide_in_width, color = {} },
  progress = { "progress", condition = conditions.hide_in_width, color = {} },
  spaces = {
    function()
      local label = "Spaces: "
      if not vim.api.nvim_buf_get_option(0, "expandtab") then
        label = "Tab size: "
      end
      return label .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
    end,
    condition = conditions.hide_in_width,
    color = {},
  },
  encoding = {
    "o:encoding",
    upper = true,
    color = {},
    condition = conditions.hide_in_width,
  },
  filetype = { "filetype", condition = conditions.hide_in_width, color = {} },
  scrollbar = {
    function()
      local current_line = vim.fn.line "."
      local total_lines = vim.fn.line "$"
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    left_padding = 0,
    right_padding = 0,
    color = { fg = colors.yellow, bg = colors.bg },
    condition = nil,
  },
}
