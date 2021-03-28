-- require('nvim-autopairs').setup()
-- 
-- local pairs_map = {
--     ["'"] = "'",
--     ['"'] = '"',
--     ['('] = ')',
--     ['['] = ']',
--     ['{'] = '}',
--     ['`'] = '`',
--     ['```'] = '```',
-- }
-- local disable_filetype = { "TelescopePrompt" }
-- local break_line_filetype = nil -- mean all file type
-- local html_break_line_filetype = {'html' , 'vue' , 'typescriptreact' , 'svelte' , 'javascriptreact'}
-- local ignored_next_char = "%w"
-- 
-- local remap = vim.api.nvim_set_keymap
-- local npairs = require('nvim-autopairs')
-- 
-- -- skip it, if you use another global object
-- _G.MUtils= {}
-- 
-- vim.g.completion_confirm_key = ""
-- MUtils.completion_confirm=function()
--   if vim.fn.pumvisible() ~= 0  then
--     if vim.fn.complete_info()["selected"] ~= -1 then
--       vim.fn["compe#confirm"]()
--       return npairs.esc("<c-y>")
--     else
--       vim.defer_fn(function()
--         vim.fn["compe#confirm"]("<cr>")
--       end, 20)
--       return npairs.esc("<c-n>")
--     end
--   else
--     return npairs.check_break_line_char()
--   end
-- end
-- 
-- 
-- remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

-- TODO switch to lua plugin when possible
vim.cmd([[
let g:lexima_no_default_rules = v:true
call lexima#set_default_rules()
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
    ]])
