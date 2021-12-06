return {
  templates_dir = join_paths(get_runtime_dir(), "site", "after", "ftplugin"),
  diagnostics = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      format = function(d)
        local t = vim.deepcopy(d)
        if d.code then
          t.message = string.format("%s [%s]", t.message, t.code):gsub("1. ", "")
        end
        return t.message
      end,
    },
  },
  document_highlight = true,
  code_lens_refresh = true,
  popup_border = "single",
  on_attach_callback = nil,
  on_init_callback = nil,
  automatic_servers_installation = true,
  buffer_mappings = {
    normal_mode = {
      ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover" },
      ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
      ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
      ["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
      ["gI"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
      ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "show signature help" },
      ["gp"] = { "<cmd>lua require'lvim.lsp.peek'.Peek('definition')<CR>", "Peek definition" },
      ["gl"] = {
        "<cmd>lua require'lvim.lsp.handlers'.show_line_diagnostics()<CR>",
        "Show line diagnostics",
      },
    },
    insert_mode = {},
    visual_mode = {},
  },
  null_ls = {
    setup = {},
    config = {},
  },
  override = {
    "angularls",
    "ansiblels",
    "csharp_ls",
    "denols",
    "ember",
    "emmet_ls",
    "eslint",
    "eslintls",
    "graphql",
    "jedi_language_server",
    "ltex",
    "phpactor",
    "pylsp",
    "rome",
    "sorbet",
    "sqlls",
    "sqls",
    "stylelint_lsp",
    "tailwindcss",
    "tflint",
    "volar",
  },
}
