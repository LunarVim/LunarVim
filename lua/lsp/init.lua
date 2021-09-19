local M = {}
local lspconfig = require "lspconfig"
local Log = require "core.log"
local utils = require "utils"
local lsp_utils = require "lsp.utils"

local function lsp_highlight_document(client)
  if lvim.lsp.document_highlight == false then
    return -- we don't need further
  end
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
  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then
    return
  end

  local keys = {
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
  }
  wk.register(keys, { mode = "n", buffer = bufnr })
end

function M.common_capabilities()
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
  if status_ok then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end

  return capabilities
end

function M.common_on_init(client, bufnr)
  if lvim.lsp.on_init_callback then
    lvim.lsp.on_init_callback(client, bufnr)
    Log:debug "Called lsp.on_init_callback"
    return
  end
end

function M.common_on_attach(client, bufnr)
  if lvim.lsp.on_attach_callback then
    lvim.lsp.on_attach_callback(client, bufnr)
    Log:debug "Called lsp.on_init_callback"
  end
  lsp_highlight_document(client)
  add_lsp_buffer_keybindings(bufnr)
end

function M.setup_by_ft(lang, opts)
  vim.validate {
    lang = { lang, "string" },
    opts = { opts, "table" },
    provider = { opts.lsp.provider, "string" },
  }

  if lsp_utils.is_client_active(opts.lsp.provider) then
    return
  end

  if not opts.lsp.setup.on_attach then
    opts.lsp.setup.on_attach = M.common_on_attach
  end
  if not opts.lsp.setup.on_init then
    opts.lsp.setup.on_init = M.common_on_init
  end
  if not opts.lsp.setup.capabilities then
    opts.lsp.setup.capabilities = M.common_capabilities()
  end

  lspconfig[opts.lsp.provider].setup(opts.lsp.setup)
end

local function bootstrap_nlsp()
  local lsp_settings_status_ok, lsp_settings = pcall(require, "nlspsettings")
  if lsp_settings_status_ok then
    lsp_settings.setup {
      config_home = utils.join_paths(get_config_dir(), "lsp-settings"),
    }
  end
end

local function is_overrided(lang)
  local overrides = lvim.lsp.override
  if type(overrides) == "table" then
    if vim.tbl_contains(overrides, lang) then
      return
    end
  end
end

function M.setup()
  vim.lsp.protocol.CompletionItemKind = lvim.lsp.completion.item_kind

  for _, sign in ipairs(lvim.lsp.diagnostics.signs.values) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  require("lsp.handlers").setup()

  bootstrap_nlsp()

  local configured_languages = lvim.ensure_configured
  Log:debug("Loading " .. #configured_languages .. " language(s): " .. vim.inspect(configured_languages))

  for _, lang in ipairs(configured_languages) do
    if not is_overrided(lang) then
      local lang_module = "lsp.providers." .. lang
      local status_ok, config = pcall(require, lang_module)
      if status_ok then
        M.setup_by_ft(lang, config)
      end
    end
  end

  require("lsp.null-ls").setup()

  require("utils").toggle_autoformat()
end

return M
