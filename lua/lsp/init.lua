local M = {
  config = {},
}

local Log = require "core.log"

function M:setup(overrides)
  local lsp_config = require "lsp.config"
  local Config = require "config"
  self.config = Config(lsp_config):merge(overrides).entries

  vim.lsp.protocol.CompletionItemKind = self.config.completion.item_kind

  for _, sign in ipairs(self.config.diagnostics.signs.values) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  require("lsp.handlers").setup {
    diagnostics = self.config.diagnostics,
    popup_border = self.config.popup_border,
  }
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#353d46
      hi LspReferenceText cterm=bold ctermbg=red guibg=#353d46
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#353d46
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function add_lsp_buffer_keybindings(bufnr)
  local which_key = require "core.builtins.which-key"

  which_key:register({
    normal_mode = {
      ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover" },
      ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
      ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
      ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
      ["gI"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
      ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "show signature help" },
      ["gp"] = { "<cmd>lua require'lsp.peek'.Peek('definition')<CR>", "Peek definition" },
      ["gl"] = {
        "<cmd>lua require'lsp.handlers'.show_line_diagnostics()<CR>",
        "Show line diagnostics",
      },
    },
  }, {
    normal_mode = {
      buffer = bufnr,
    },
  })
end

function M:common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not status_ok then
    return
  end
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  return capabilities
end

function M:get_ls_capabilities(client_id)
  local client
  if not client_id then
    local buf_clients = vim.lsp.buf_get_clients()
    for _, buf_client in ipairs(buf_clients) do
      if buf_client.name ~= "null-ls" then
        client_id = buf_client.id
        break
      end
    end
  end
  if not client_id then
    error "Unable to determine client_id"
  end

  client = vim.lsp.get_client_by_id(tonumber(client_id))

  local enabled_caps = {}

  for k, v in pairs(client.resolved_capabilities) do
    if v == true then
      table.insert(enabled_caps, k)
    end
  end

  return enabled_caps
end

function M:common_on_init(client, bufnr)
  if self.config.on_init_callback then
    self.config.on_init_callback(client, bufnr)
    Log:debug "Called lsp.on_init_callback"
    return
  end

  local formatters = self.config.lang[vim.bo.filetype].formatters
  if not vim.tbl_isempty(formatters) and formatters[1]["exe"] ~= nil and formatters[1].exe ~= "" then
    client.resolved_capabilities.document_formatting = false
    Log:debug(
      string.format("Overriding language server [%s] with format provider [%s]", client.name, formatters[1].exe)
    )
  end
end

function M:common_on_attach(client, bufnr)
  if self.config.on_attach_callback then
    self.config.on_attach_callback(client, bufnr)
    Log:debug "Called lsp.on_init_callback"
  end
  if self.config.document_highlight then
    lsp_highlight_document(client)
  end
  add_lsp_buffer_keybindings(bufnr)

  local filetype = vim.bo.filetype
  local providers = vim.tbl_deep_extend(
    "force",
    { formatters = {}, linters = {} },
    { formatters = self.config.lang[filetype].formatters, linters = self.config.lang[filetype].linters }
  )
  require("lsp.null-ls").setup(providers, filetype)
end

function M:configure(filetype)
  local lsp_utils = require "lsp.utils"
  local client = self.config.lang[filetype].client or {}
  if client.active == false or lsp_utils.is_client_active(client.name) then
    return
  end

  -- TODO: override should be in 'lsp.'
  local overrides = self.config.override
  if type(overrides) == "table" then
    if vim.tbl_contains(overrides, filetype) then
      return
    end
  end

  if not self.config.lang[filetype] then
    return
  end

  local default_client = {
    setup = {
      on_attach = function(...)
        return M:common_on_attach(...)
      end,
      on_init = function(...)
        return M:common_on_init(...)
      end,
      capabilities = M:common_capabilities(),
    },
  }
  client = vim.tbl_deep_extend("force", default_client, client)
  local lspconfig = require "lspconfig"
  lspconfig[client.name].setup(client.setup)
end

-- FIXME: this should return a list instead
function M:get_active_client_by_ft(filetype)
  if not self.config.lang[filetype] or not self.config.lang[filetype].client then
    return nil
  end

  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == self.config.lang[filetype].client.name then
      return client
    end
  end
  return nil
end

return M
