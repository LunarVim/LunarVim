-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.cmd([[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]])
vim.cmd([[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

-- Set completeopt to have a better completion experience
vim.cmd([[set completeopt=menuone,noinsert,noselect]])

-- Avoid showing message extra message when using completion
vim.cmd([[set shortmess+=c]])

vim.cmd([[imap <tab> <Plug>(completion_smart_tab)]])
vim.cmd([[imap <s-tab> <Plug>(completion_smart_s_tab)]])
