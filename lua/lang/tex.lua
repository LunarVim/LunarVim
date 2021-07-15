local M = {}

M.config = function()
  O.lang.latex = {
    filetypes = { "tex", "bib" },
    aux_directory = nil,
    bibtex_formatter = "texlab",
    diagnostics_delay = 300,
    formatter_line_length = 80,
    latex_formatter = "latexindent",
    build = {
      executable = "latexmk",
      args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
      on_save = false,
      forward_search_after = false,
    },
    chktex = {
      on_open_and_save = false,
      on_edit = false,
    },
    forward_search = {
      executable = nil,
      args = {},
    },
    latexindent = {
      ["local"] = nil,
      modify_line_breaks = false,
    },
    diagnostics = {
      virtual_text = { spacing = 0, prefix = "" },
      signs = true,
      underline = true,
    },
    auto_save = false,
    ignore_errors = {},
  }
end

M.format = function()
  -- TODO: implement formatter for language
  return "No formatter available!"
end

M.lint = function()
  -- TODO: implement linters (if applicable)
  return "No linters configured!"
end

M.lsp = function()
  if require("lv-utils").check_lsp_client_active "texlab" then
    return
  end

  local preview_settings = {}

  local sumatrapdf_args = { "-reuse-instance", "%p", "-forward-search", "%f", "%l" }
  local evince_args = { "-f", "%l", "%p", '"code -g %f:%l"' }
  local okular_args = { "--unique", "file:%p#src:%l%f" }
  local zathura_args = { "--synctex-forward", "%l:1:%f", "%p" }
  local qpdfview_args = { "--unique", "%p#src:%f:%l:1" }
  local skim_args = { "%l", "%p", "%f" }

  if O.lang.latex.forward_search.executable == "C:/Users/{User}/AppData/Local/SumatraPDF/SumatraPDF.exe" then
    preview_settings = sumatrapdf_args
  elseif O.lang.latex.forward_search.executable == "evince-synctex" then
    preview_settings = evince_args
  elseif O.lang.latex.forward_search.executable == "okular" then
    preview_settings = okular_args
  elseif O.lang.latex.forward_search.executable == "zathura" then
    preview_settings = zathura_args
  elseif O.lang.latex.forward_search.executable == "qpdfview" then
    preview_settings = qpdfview_args
  elseif O.lang.latex.forward_search.executable == "/Applications/Skim.app/Contents/SharedSupport/displayline" then
    preview_settings = skim_args
  end

  require("lspconfig").texlab.setup {
    cmd = { DATA_PATH .. "/lspinstall/latex/texlab" },
    on_attach = require("lsp").common_on_attach,
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = O.lang.latex.diagnostics.virtual_text,
        signs = O.lang.latex.diagnostics.signs,
        underline = O.lang.latex.diagnostics.underline,
        update_in_insert = true,
      }),
    },
    filetypes = { "tex", "bib" },
    settings = {
      texlab = {
        auxDirectory = O.lang.latex.aux_directory,
        bibtexFormatter = O.lang.latex.bibtex_formatter,
        build = {
          args = O.lang.latex.build.args,
          executable = O.lang.latex.build.executable,
          forwardSearchAfter = O.lang.latex.build.forward_search_after,
          onSave = O.lang.latex.build.on_save,
        },
        chktex = {
          onEdit = O.lang.latex.chktex.on_edit,
          onOpenAndSave = O.lang.latex.chktex.on_open_and_save,
        },
        diagnosticsDelay = O.lang.latex.diagnostics_delay,
        formatterLineLength = O.lang.latex.formatter_line_length,
        forwardSearch = {
          args = preview_settings,
          executable = O.lang.latex.forward_search.executable,
        },
        latexFormatter = O.lang.latex.latex_formatter,
        latexindent = {
          modifyLineBreaks = O.lang.latex.latexindent.modify_line_breaks,
        },
      },
    },
  }
  vim.g.vimtex_compiler_method = "latexmk"
  vim.g.vimtex_view_method = "zathura"
  vim.g.vimtex_fold_enabled = 0
  vim.g.vimtex_quickfix_ignore_filters = O.lang.latex.ignore_errors

  O.plugin.which_key.mappings["t"] = {
    name = "+Latex",
    c = { "<cmd>VimtexCompile<cr>", "Toggle Compilation Mode" },
    f = { "<cmd>call vimtex#fzf#run()<cr>", "Fzf Find" },
    i = { "<cmd>VimtexInfo<cr>", "Project Information" },
    s = { "<cmd>VimtexStop<cr>", "Stop Project Compilation" },
    t = { "<cmd>VimtexTocToggle<cr>", "Toggle Table Of Content" },
    v = { "<cmd>VimtexView<cr>", "View PDF" },
    b = { "<cmd>TexlabBuild<cr>", "Build with Texlab" },
    p = { "<cmd>TexlabForward<cr>", "Preview with Texlab" },
  }

  -- Compile on initialization, cleanup on quit
  vim.api.nvim_exec(
    [[
        augroup vimtex_event_1
            au!
            au User VimtexEventQuit     call vimtex#compiler#clean(0)
            au User VimtexEventInitPost call vimtex#compiler#compile()
        augroup END
    ]],
    false
  )
  if O.lang.latex.auto_save then
    vim.api.nvim_exec([[au FocusLost * :wa]], false)
  end
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M
