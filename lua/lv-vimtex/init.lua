vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_fold_enabled = 0

O.user_which_key["L"] = {
  name = "+Latex",
  c = { "<cmd>VimtexCompile<cr>", "Toggle Compilation Mode" },
  f = { "<cmd>call vimtex#fzf#run()<cr>", "Fzf Find" },
  i = { "<cmd>VimtexInfo<cr>", "Project Information" },
  s = { "<cmd>VimtexStop<cr>", "Stop Project Compilation" },
  t = { "<cmd>VimtexTocToggle<cr>", "Toggle Table Of Content" },
  v = { "<cmd>VimtexView<cr>", "View PDF" },
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
