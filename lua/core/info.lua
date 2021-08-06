local M = {}
local u = require "utils"
local null_ls_handler = require "lsp.null-ls"
local indent = "  "

M.banner = {
  "",
  "",
  "⠀⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀     ⠀⠀⠀   ⠀⠀ ⣺⡿⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀",
  "⠀⣿⠇⠀⠀⠀⠀⠀⣤⡄⠀⠀⢠⣤⡄⠀.⣠⣤⣤⣤⡀⠀⠀⢀⣤⣤⣤⣤⡄⠀⠀⠀⣤⣄⣤⣤⣤⠀⠀ ⣿⣯  ⣿⡟⠀   ⣤⣤⠀⠀⠀⠀⣠⣤⣤⣤⣄⣤⣤",
  "⢠⣿⠀⠀⠀⠀⠀⠀⣿⠃⠀⠀⣸⣿⠁⠀⣿⣿⠉⠀⠈⣿⡇⠀⠀⠛⠋⠀⠀⢹⣿⠀⠀⠀⣿⠏⠀⠸⠿⠃⠀⣿⣿⠀⣰⡟⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⣿⡟⢸⣿⡇⢀⣿",
  "⣸⡇⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⣿⡟⠀⢠⣿⡇⠀⠀⢰⣿⡇⠀⣰⣾⠟⠛⠛⣻⡇⠀⠀⢸⡿⠀⠀⠀⠀⠀⠀⢻⣿⢰⣿⠀⠀⠀⠀⠀⠀⣾⡇⠀⠀⠀⢸⣿⠇⢸⣿⠀⢸⡏",
  "⣿⣧⣤⣤⣤⡄⠀⠘⣿⣤⣤⡤⣿⠇⠀⢸⣿⠁⠀⠀⣼⣿⠀⠀⢿⣿⣤⣤⠔⣿⠃⠀⠀⣾⡇⠀⠀⠀⠀⠀⠀⢸⣿⣿⠋⠀⠀⠀⢠⣤⣤⣿⣥⣤⡄⠀⣼⣿⠀⣸⡏⠀⣿⠃",
  "⠉⠉⠉⠉⠉⠁⠀⠀⠈⠉⠉⠀⠉⠀⠀⠈⠉⠀⠀⠀⠉⠉⠀⠀⠀⠉⠉⠁⠈⠉⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠁⠀⠉⠁⠀⠉⠁⠀⠉⠀",
  "",
  "",
}

local function str_list(list)
  return "[ " .. table.concat(list, ", ") .. " ]"
end

local function get_formatter_suggestion_msg(ft)
  local supported_formatters = u.get_supported_formatters_by_filetype(ft)
  return {
    "-------------------------------------------------------------------",
    "",
    "  HINT ",
    "",
    indent .. "* List of supported formatters: " .. str_list(supported_formatters),
    "",
    indent .. "You can enable a supported formatter by adding this to your config.lua",
    "",
    indent
      .. "lvim.lang."
      .. tostring(ft)
      .. [[.formatting = { { exe = ']]
      .. table.concat(supported_formatters, "|")
      .. [[' } }]],
    "",
    "-------------------------------------------------------------------",
  }
end

local function get_linter_suggestion_msg(ft)
  local supported_linters = u.get_supported_linters_by_filetype(ft)
  return {
    "-------------------------------------------------------------------",
    "",
    "  HINT ",
    "",
    indent .. "* List of supported linters: " .. str_list(supported_linters),
    "",
    indent .. "You can enable a supported linter by adding this to your config.lua",
    "",
    indent
      .. "lvim.lang."
      .. tostring(ft)
      .. [[.linters = { { exe = ']]
      .. table.concat(supported_linters, "|")
      .. [[' } }]],
    "",
    "-------------------------------------------------------------------",
  }
end

---creates an average size popup
---@param buf_lines a list of lines to print
---@param callback could be used to set syntax highlighting rules for example
---@return bufnr buffer number of the created buffer
---@return win_id window ID of the created popup
function M.create_simple_popup(buf_lines, callback)
  -- runtime/lua/vim/lsp/util.lua
  local bufnr = vim.api.nvim_create_buf(false, true)
  local height_percentage = 0.7
  local width_percentage = 0.8
  local row_start_percentage = (1 - height_percentage) / 2
  local col_start_percentage = (1 - width_percentage) / 2
  local opts = {}
  opts.relative = "editor"
  opts.height = math.ceil(vim.o.lines * height_percentage)
  opts.row = math.ceil(vim.o.lines * row_start_percentage)
  opts.col = math.floor(vim.o.columns * col_start_percentage)
  opts.width = math.floor(vim.o.columns * width_percentage)
  opts.border = {
    "┌",
    "-",
    "┐",
    "|",
    "┘",
    "-",
    "└",
    "|",
  }

  local win_id = vim.api.nvim_open_win(bufnr, true, opts)

  vim.api.nvim_win_set_buf(win_id, bufnr)
  -- this needs to be window option!
  vim.api.nvim_win_set_option(win_id, "number", false)
  vim.cmd "setlocal nocursorcolumn"
  vim.cmd "setlocal wrap"
  -- set buffer options
  vim.api.nvim_buf_set_option(bufnr, "filetype", "lspinfo")
  vim.lsp.util.close_preview_autocmd({ "BufHidden", "BufLeave" }, win_id)
  buf_lines = vim.lsp.util._trim(buf_lines, {})
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, buf_lines)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
  if type(callback) == "function" then
    callback()
  end
  return bufnr, win_id
end

function M.toggle_popup(ft)
  local client = u.get_active_client_by_ft(ft)
  local is_client_active = not client.is_stopped()
  local client_enabled_caps = require("lsp").get_ls_capabilities(client.id)
  local num_caps = vim.tbl_count(client_enabled_caps)
  local null_ls_providers = null_ls_handler.get_registered_providers_by_filetype(ft)

  local missing_linters = lvim.lang[ft].linters._failed_requests or {}
  local missing_formatters = lvim.lang[ft].formatters._failed_requests or {}

  local buf_lines = {}
  vim.list_extend(buf_lines, M.banner)

  local header = {
    "Detected filetype is: " .. tostring(ft),
    "",
    "Treesitter active: " .. tostring(next(vim.treesitter.highlighter.active) ~= nil),
    "",
    "",
  }
  vim.list_extend(buf_lines, header)

  local lsp_info = {
    "Associated language-server: " .. client.name,
    indent .. "* Active: " .. tostring(is_client_active) .. ", id: " .. tostring(client.id),
    indent .. "* Formatting support: " .. tostring(client.resolved_capabilities.document_formatting),
    indent .. "* Capabilities list: " .. table.concat(vim.list_slice(client_enabled_caps, 1, num_caps / 2), ", "),
    indent .. indent .. indent .. table.concat(vim.list_slice(client_enabled_caps, ((num_caps / 2) + 1)), ", "),
    "",
  }
  vim.list_extend(buf_lines, lsp_info)

  local null_ls_info = {
    "Configured providers: " .. table.concat(null_ls_providers, "  , ") .. "  ",
    "",
  }
  vim.list_extend(buf_lines, null_ls_info)

  local missing_formatters_status
  if vim.tbl_count(missing_formatters) > 0 then
    missing_formatters_status = { "Missing formatters: " .. table.concat(missing_formatters, "  , ") .. "  ", "" }
    vim.list_extend(buf_lines, missing_formatters_status)
  end

  local missing_linters_status
  if vim.tbl_count(missing_linters) > 0 then
    missing_linters_status = { "Missing linters: " .. table.concat(missing_linters, "  , ") .. "  ", "" }
    vim.list_extend(buf_lines, missing_linters_status)
  end

  vim.list_extend(buf_lines, get_formatter_suggestion_msg(ft))

  vim.list_extend(buf_lines, get_linter_suggestion_msg(ft))

  local function set_syntax_hl()
    --TODO: highlighting is either inconsistent or not working :\
    vim.cmd("syntax match Identifier /filetype is: .*\\zs\\<" .. ft .. "\\>/")
    vim.cmd("syntax match Identifier /server: .*\\zs\\<" .. client.name .. "\\>/")
    vim.cmd("syntax match Identifier /providers: .*\\zs\\<" .. table.concat(null_ls_providers, ", ") .. "\\>/")
    vim.cmd("syntax match Identifier /formatters: .*\\zs\\<" .. table.concat(missing_formatters, ", ") .. "\\>/")
    vim.cmd("syntax match Identifier /linters: .*\\zs\\<" .. table.concat(missing_linters, ", ") .. "\\>/")
  end

  return M.create_simple_popup(buf_lines, set_syntax_hl)
end
return M
