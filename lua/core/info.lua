local M = {
  banner = {
    "",
    [[    __                          _    ___         ]],
    [[   / /   __  ______  ____ _____| |  / (_)___ ___ ]],
    [[  / /   / / / / __ \/ __ `/ ___/ | / / / __ `__ \]],
    [[ / /___/ /_/ / / / / /_/ / /   | |/ / / / / / / /]],
    [[/_____/\__,_/_/ /_/\__,_/_/    |___/_/_/ /_/ /_/ ]],
  },
}

local fmt = string.format
local text = require "interface.text"

local function str_list(list)
  return fmt("[ %s ]", table.concat(list, ", "))
end

local function get_formatter_suggestion_msg(ft)
  local config = require "config"
  local null_formatters = require "lsp.null-ls.formatters"
  local supported_formatters = null_formatters.list_available(ft)
  local section = {
    " HINT ",
    "",
    fmt("* List of supported formatters: %s", str_list(supported_formatters)),
  }

  if not vim.tbl_isempty(supported_formatters) then
    vim.list_extend(section, {
      "* Configured formatter needs to be installed and executable.",
      fmt("* Enable installed formatter(s) with following config in %s", config.path),
      "",
      fmt("  lvim.lang.%s.formatters = { { exe = '%s' } }", ft, table.concat(supported_formatters, "│")),
    })
  end

  return section
end

local function get_linter_suggestion_msg(ft)
  local config = require "config"
  local null_linters = require "lsp.null-ls.linters"
  local supported_linters = null_linters.list_available(ft)
  local section = {
    " HINT ",
    "",
    fmt("* List of supported linters: %s", str_list(supported_linters)),
  }

  if not vim.tbl_isempty(supported_linters) then
    vim.list_extend(section, {
      "* Configured linter needs to be installed and executable.",
      fmt("* Enable installed linter(s) with following config in %s", config.path),
      "",
      fmt("  lvim.lang.%s.linters = { { exe = '%s' } }", ft, table.concat(supported_linters, "│")),
    })
  end

  return section
end

local function tbl_set_highlight(terms, highlight_group)
  for _, v in pairs(terms) do
    vim.cmd('let m=matchadd("' .. highlight_group .. '", "' .. v .. "[ ,│']\")")
  end
end

local function make_client_info(client)
  local client_enabled_caps = require("lsp.utils").get_ls_capabilities(client.id)
  local name = client.name
  local id = client.id
  local document_formatting = client.resolved_capabilities.document_formatting
  local client_info = {
    fmt("* Name:                 %s", name),
    fmt("* Id:                   %s", tostring(id)),
    fmt("* Supports formatting:  %s", tostring(document_formatting)),
  }
  if not vim.tbl_isempty(client_enabled_caps) then
    local caps_text = "* Capabilities list:    "
    local caps_text_len = caps_text:len()
    local enabled_caps = text.format_table(client_enabled_caps, 3, " | ")
    enabled_caps = text.shift_right(enabled_caps, caps_text_len)
    enabled_caps[1] = fmt("%s%s", caps_text, enabled_caps[1]:sub(caps_text_len + 1))
    vim.list_extend(client_info, enabled_caps)
  end

  return client_info
end

function M.toggle_popup(ft)
  local lsp_utils = require "lsp.utils"
  local clients = lsp_utils.get_active_client_by_ft(ft)
  local client_names = {}

  local header = {
    fmt("Detected filetype:      %s", ft),
    fmt("Treesitter active:      %s", tostring(next(vim.treesitter.highlighter.active) ~= nil)),
  }

  local lsp_info = {
    "Language Server Protocol (LSP) info",
    fmt "* Associated server(s):",
  }

  for _, client in pairs(clients) do
    vim.list_extend(lsp_info, make_client_info(client))
    table.insert(client_names, client.name)
  end

  local null_formatters = require "lsp.null-ls.formatters"
  local null_linters = require "lsp.null-ls.linters"
  local registered_formatters = null_formatters.list_supported_names(ft)
  local registered_linters = null_linters.list_supported_names(ft)
  local registered_providers = {}
  vim.list_extend(registered_providers, registered_formatters)
  vim.list_extend(registered_providers, registered_linters)
  local registered_count = vim.tbl_count(registered_providers)
  local null_ls_info = {
    "Formatters and linters",
    fmt(
      "* Configured providers: %s%s",
      table.concat(registered_providers, "  , "),
      registered_count > 0 and "  " or ""
    ),
  }

  local content_provider = function(popup)
    local content = {}

    for _, section in ipairs {
      M.banner,
      { "" },
      { "" },
      header,
      { "" },
      lsp_info,
      { "" },
      null_ls_info,
      { "" },
      { "" },
      get_formatter_suggestion_msg(ft),
      { "" },
      { "" },
      get_linter_suggestion_msg(ft),
    } do
      vim.list_extend(content, section)
    end

    return text.align_left(popup, content, 0.5)
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
    -- tbl_set_highlight(require("lsp.null-ls.formatters").list_available(ft), "LvimInfoIdentifier")
    -- tbl_set_highlight(require("lsp.null-ls.linters").list_available(ft), "LvimInfoIdentifier")
  end

  local Popup = require("interface.popup"):new {
    win_opts = { number = false },
    buf_opts = { modifiable = false, filetype = "lspinfo" },
  }
  Popup:display(content_provider)
  set_syntax_hl()

  return Popup
end
return M
