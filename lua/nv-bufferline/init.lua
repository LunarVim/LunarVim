require'bufferline'.setup{}
vim.api.nvim_set_keymap('n', '<TAB>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })


--" These commands will move the current buffer backwards or forwards in the bufferline
--nnoremap <silent><mymap> :BufferLineMoveNext<CR>
--nnoremap <silent><mymap> :BufferLineMovePrev<CR>

--" These commands will sort buffers by directory, language, or a custom criteria
--nnoremap <silent>be :BufferLineSortByExtension<CR>
--nnoremap <silent>bd :BufferLineSortByDirectory<CR>
--nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>
