local M = {}

function M.get_all_supported_servers()
  return {
    "bashls",
    "beancount",
    "bicep",
    "clangd",
    "clojure_lsp",
    "cmake",
    "crystalline",
    "cssls",
    -- "dartls",
    "dockerls",
    "elixirls",
    "elmls",
    "erlangls",
    "fortls",
    "gdscript",
    "gopls",
    "graphql",
    "hls",
    "html",
    "intelephense",
    -- "jdtls",
    "jsonls",
    "julials",
    "kotlin_language_server",
    "metals",
    "omnisharp",
    "powershell_es",
    "puppet",
    "pyright",
    "r_language_server",
    "rnix",
    "rust_analyzer",
    "serve_d",
    "solang",
    "solargraph",
    "sourcekit",
    "sqls",
    "sumneko_lua",
    "svelte",
    "tailwindcss",
    "terraformls",
    "texlab",
    "tsserver",
    "vimls",
    "vuels",
    "yamlls",
    "zls",
  }
end

function M.init_defaults(languages)
  languages = languages or lvim.ensure_configured
  for _, entry in ipairs(languages) do
    if not lvim.lang[entry] then
      lvim.lang[entry] = {
        formatters = {},
        linters = {},
      }
    end
  end
end

function M.ensure_configured(languages)
  local status_ok, lspinstall = pcall(require, "lspinstall")
  if not status_ok then
    return
  end
  local installer_supported_languages = lspinstall.available_servers()
  for _, entry in ipairs(languages) do
    if vim.tbl_contains(installer_supported_languages, entry) then
      if not lspinstall.is_server_installer(entry) then
        lspinstall.install_server(entry)
      end
    end
  end
end

return M
