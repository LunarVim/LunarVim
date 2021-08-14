local M = {}

local text = require "interface.text"
local fmt = string.format

M.banner = {
  "",
  [[    __                          _    ___         ]],
  [[   / /   __  ______  ____ _____| |  / (_)___ ___ ]],
  [[  / /   / / / / __ \/ __ `/ ___/ | / / / __ `__ \]],
  [[ / /___/ /_/ / / / / /_/ / /   | |/ / / / / / / /]],
  [[/_____/\__,_/_/ /_/\__,_/_/    |___/_/_/ /_/ /_/ ]],
  "",
}

local function str_list(list)
  return fmt("[ %s ]", table.concat(list, ", "))
end

local function get_formatter_suggestion_msg(ft)
  local null_formatters = require "lsp.null-ls.formatters"
  local supported_formatters = null_formatters.list_available(ft)
  return {
    -- indent
    --   .. "───────────────────────────────────────────────────────────────────",
    "",
    " HINT ",
    "",
    fmt("* List of supported formatters: %s", str_list(supported_formatters)),
    "* Configured formatter needs to be installed and executable.",
    fmt("* Enable installed formatter(s) with following config in %s", USER_CONFIG_PATH),
    "",
    fmt("  lvim.lang.%s.formatters = { { exe = '%s' } }", ft, table.concat(supported_formatters, "│")),
    "",
  }
end

local function get_linter_suggestion_msg(ft)
  local null_linters = require "lsp.null-ls.linters"
  local supported_linters = null_linters.list_available(ft)
  return {
    -- indent
    --   .. "───────────────────────────────────────────────────────────────────",
    "",
    " HINT ",
    "",
    fmt("* List of supported linters: %s", str_list(supported_linters)),
    "* Configured linter needs to be installed and executable.",
    fmt("* Enable installed linter(s) with following config in %s", USER_CONFIG_PATH),
    "",
    fmt("  lvim.lang.%s.linters = { { exe = '%s' } }", ft, table.concat(supported_linters, "│")),
    "",
  }
end

---creates an average size popup
---@param buf_lines a list of lines to print
---@param callback could be used to set syntax highlighting rules for example
---@return bufnr buffer number of the created buffer
---@return win_id window ID of the created popup
function M.create_simple_popup(content_formatter, callback)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local opts = {
    relative = "editor",
    height = math.ceil(vim.o.lines * 0.9),
    width = math.floor(vim.o.columns * 0.8),
    style = "minimal",
    border = "rounded",
  }
  opts.col = (vim.o.columns - opts.width) / 2
  opts.row = (vim.o.lines - opts.height) / 2

  local win_id = vim.api.nvim_open_win(bufnr, true, opts)
  vim.api.nvim_win_set_buf(win_id, bufnr)
  -- this needs to be window option!
  vim.api.nvim_win_set_option(win_id, "number", false)
  vim.cmd "setlocal nocursorcolumn"
  vim.cmd "setlocal wrap"
  -- set buffer options
  vim.api.nvim_buf_set_option(bufnr, "filetype", "lspinfo")
  vim.lsp.util.close_preview_autocmd({ "BufHidden", "BufLeave" }, win_id)

  local buf_lines = content_formatter { width = opts.width }
  -- buf_lines = vim.lsp.util._trim(buf_lines, {})
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, buf_lines)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)

  callback()

  return bufnr, win_id
end

local function tbl_set_highlight(terms, highlight_group)
  for _, v in pairs(terms) do
    vim.cmd('let m=matchadd("' .. highlight_group .. '", "' .. v .. "[ ,│']\")")
  end
end

function M.toggle_popup(ft)
  local lsp_utils = require "lsp.utils"
  local client = lsp_utils.get_active_client_by_ft(ft)
  local is_client_active = false
  local client_enabled_caps = {}
  local client_name = ""
  local client_id = 0
  local document_formatting = false
  local num_caps = 0
  if client ~= nil then
    is_client_active = not client.is_stopped()
    client_enabled_caps = require("lsp").get_ls_capabilities(client.id)
    num_caps = vim.tbl_count(client_enabled_caps)
    client_name = client.name
    client_id = client.id
    document_formatting = client.resolved_capabilities.document_formatting
  end

  local header = {
    fmt("Detected filetype:     %s", ft),
    fmt("Treesitter active:     %s", tostring(next(vim.treesitter.highlighter.active) ~= nil)),
    "",
  }

  local lsp_info = {
    "Language Server Protocol (LSP) info",
    fmt("* Associated server:   %s", client_name),
    fmt("* Active:              %s (id: %d)", tostring(is_client_active), client_id),
    fmt("* Supports formatting: %s", tostring(document_formatting)),
    fmt("* Capabilities list:   %s", table.concat(vim.list_slice(client_enabled_caps, 1, num_caps / 2), ", ")),
    table.concat(vim.list_slice(client_enabled_caps, ((num_caps / 2) + 1)), ", "),
    "",
  }

  local null_ls = require "lsp.null-ls"
  local registered_providers = null_ls.list_supported_provider_names(ft)
  local null_ls_info = {
    "Formatters and linters",
    fmt("* Configured providers: %s", table.concat(registered_providers, "  , ") .. "  "),
  }

  local null_formatters = require "lsp.null-ls.formatters"
  local missing_formatters = null_formatters.list_unsupported_names(ft)
  local missing_formatters_status = {}
  if vim.tbl_count(missing_formatters) > 0 then
    table.insert(
      missing_formatters_status,
      fmt("* Missing formatters:   %s", table.concat(missing_formatters, "  , ") .. "  ")
    )
  end

  local null_linters = require "lsp.null-ls.linters"
  local missing_linters = null_linters.list_unsupported_names(ft)
  local missing_linters_status = {}
  if vim.tbl_count(missing_linters) > 0 then
    table.insert(
      missing_linters_status,
      fmt("* Missing linters:      %s", table.concat(missing_linters, "  , ") .. "  ")
    )
  end

  local content_formatter = function(container)
    local content = {}

    for _, section in ipairs {
      M.banner,
      header,
      lsp_info,
      null_ls_info,
      missing_formatters_status,
      missing_linters_status,
      { "" },
      get_formatter_suggestion_msg(ft),
      get_linter_suggestion_msg(ft),
    } do
      vim.list_extend(content, section)
    end

    return text.align(container, content, 0.5)
  end

  local function set_syntax_hl()
    vim.cmd [[highlight LvimInfoIdentifier gui=bold]]
    vim.cmd [[highlight link LvimInfoHeader Type]]
    vim.cmd [[let m=matchadd("LvimInfoHeader", "Language Server Protocol (LSP) info")]]
    vim.cmd [[let m=matchadd("LvimInfoHeader", "Formatters and linters")]]
    vim.cmd('let m=matchadd("LvimInfoIdentifier", " ' .. ft .. '$")')
    vim.cmd 'let m=matchadd("string", "true")'
    vim.cmd 'let m=matchadd("error", "false")'
    tbl_set_highlight(registered_providers, "LvimInfoIdentifier")
    tbl_set_highlight(missing_formatters, "LvimInfoIdentifier")
    tbl_set_highlight(missing_linters, "LvimInfoIdentifier")
    -- tbl_set_highlight(require("lsp.null-ls.formatters").list_available(ft), "LvimInfoIdentifier")
    -- tbl_set_highlight(require("lsp.null-ls.linters").list_available(ft), "LvimInfoIdentifier")
    vim.cmd('let m=matchadd("LvimInfoIdentifier", "' .. client_name .. '")')
  end

  return M.create_simple_popup(content_formatter, set_syntax_hl)
end
return M
