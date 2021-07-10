vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_fold_enabled = 0
vim.g.vimtex_quickfix_ignore_filters = O.vimtex_ignore_errors
-- Compile on initialization, cleanup on quit
-- O.autosavevimtex = false
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
if (O.vimtex_autosave)
then
  vim.api.nvim_exec([[au FocusLost * :wa]],false)
end
