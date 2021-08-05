local M = {}
local lspui = require "lspconfig/_lspui"
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

function M.toggle_display(ft)
  --- set floating window option
  local win_info = lspui.percentage_range_window(0.7, 0.7)
  local bufnr, win_id = win_info.bufnr, win_info.win_id

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

  buf_lines = vim.lsp.util._trim(buf_lines, {})
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, buf_lines)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
  vim.api.nvim_buf_set_option(bufnr, "filetype", "lspinfo")
  vim.lsp.util.close_preview_autocmd({ "BufHidden", "BufLeave" }, win_id)
  vim.cmd("syntax match Identifier /filetype is: .*\\zs\\<" .. ft .. "\\>/")
  vim.cmd("syntax match Identifier /server: .*\\zs\\<" .. client.name .. "\\>/")
  -- TODO: highlighting is either inconsistent or not working :\
  vim.cmd("syntax match Identifier /providers: .*\\zs\\<" .. table.concat(null_ls_providers, ", ") .. "\\>/")
  vim.cmd("syntax match Identifier /formatters: .*\\zs\\<" .. table.concat(missing_formatters, ", ") .. "\\>/")
  vim.cmd("syntax match Identifier /linters: .*\\zs\\<" .. table.concat(missing_linters, ", ") .. "\\>/")
end

return M
