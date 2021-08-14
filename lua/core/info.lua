local M = {}

local text = require "interface.text"

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
  return "[ " .. table.concat(list, ", ") .. " ]"
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
    "* List of supported formatters: " .. str_list(supported_formatters),
    "* Configured formatter needs to be installed and executable.",
    "* Enable installed formatter(s) with following config in ~/.config/lvim/config.lua",
    "",
    "  lvim.lang."
      .. tostring(ft)
      .. [[.formatters = { { exe = ']]
      .. table.concat(supported_formatters, "│")
      .. [[' } }]],
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
    "* List of supported linters: " .. str_list(supported_linters),
    "* Configured linter needs to be installed and executable.",
    "* Enable installed linter(s) with following config in ~/.config/lvim/config.lua",
    "",
    "  lvim.lang." .. tostring(ft) .. [[.linters = { { exe = ']] .. table.concat(supported_linters, "│") .. [[' } }]],
    "",
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
  local height_percentage = 0.9
  local width_percentage = 0.8
  local row_start_percentage = (1 - height_percentage) / 2
  local col_start_percentage = (1 - width_percentage) / 2
  local opts = {}
  opts.relative = "editor"
  opts.height = math.min(math.ceil(vim.o.lines * height_percentage), #buf_lines)
  opts.row = math.ceil(vim.o.lines * row_start_percentage)
  opts.col = math.floor(vim.o.columns * col_start_percentage)
  opts.width = math.floor(vim.o.columns * width_percentage)
  opts.style = "minimal"
  opts.border = "rounded"
  --[[
  opts.border = {
    lvim.builtin.telescope.defaults.borderchars[5], -- "┌",
    lvim.builtin.telescope.defaults.borderchars[3], -- "-",
    lvim.builtin.telescope.defaults.borderchars[6], -- "┐",
    lvim.builtin.telescope.defaults.borderchars[2], -- "|",
    lvim.builtin.telescope.defaults.borderchars[7], -- "┘",
    lvim.builtin.telescope.defaults.borderchars[3], -- "-",
    lvim.builtin.telescope.defaults.borderchars[8], -- "└",
    lvim.builtin.telescope.defaults.borderchars[4], -- "|",
  }
  --]]

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

local function tbl_set_highlight(terms, highlight_group)
  if type(terms) ~= "table" then
    return
  end

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

  local buf_lines = {}
  vim.list_extend(buf_lines, M.banner)

  local header = {
    "Detected filetype:     " .. tostring(ft),
    "Treesitter active:     " .. tostring(next(vim.treesitter.highlighter.active) ~= nil),
    "",
  }
  vim.list_extend(buf_lines, header)

  local lsp_info = {
    "Language Server Protocol (LSP) info",
    "* Associated server:   " .. client_name,
    "* Active:              " .. tostring(is_client_active) .. " (id: " .. tostring(client_id) .. ")",
    "* Supports formatting: " .. tostring(document_formatting),
    "* Capabilities list:   " .. table.concat(vim.list_slice(client_enabled_caps, 1, num_caps / 2), ", "),
    table.concat(vim.list_slice(client_enabled_caps, ((num_caps / 2) + 1)), ", "),
    "",
  }
  vim.list_extend(buf_lines, lsp_info)

  local null_ls = require "lsp.null-ls"
  local registered_providers = null_ls.list_supported_provider_names(ft)
  local null_ls_info = {
    "Formatters and linters",
    "* Configured providers: " .. table.concat(registered_providers, "  , ") .. "  ",
  }
  vim.list_extend(buf_lines, null_ls_info)

  local null_formatters = require "lsp.null-ls.formatters"
  local missing_formatters = null_formatters.list_unsupported_names(ft)
  if vim.tbl_count(missing_formatters) > 0 then
    local missing_formatters_status = {
      "* Missing formatters:   " .. table.concat(missing_formatters, "  , ") .. "  ",
    }
    vim.list_extend(buf_lines, missing_formatters_status)
  end

  local null_linters = require "lsp.null-ls.linters"
  local missing_linters = null_linters.list_unsupported_names(ft)
  if vim.tbl_count(missing_linters) > 0 then
    local missing_linters_status = {
      "* Missing linters:      " .. table.concat(missing_linters, "  , ") .. "  ",
    }
    vim.list_extend(buf_lines, missing_linters_status)
  end

  vim.list_extend(buf_lines, { "" })

  vim.list_extend(buf_lines, get_formatter_suggestion_msg(ft))
  vim.list_extend(buf_lines, get_linter_suggestion_msg(ft))

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

  buf_lines = text.align({ width = vim.o.columns }, buf_lines, 0.15)
  return M.create_simple_popup(buf_lines, set_syntax_hl)
end
return M
