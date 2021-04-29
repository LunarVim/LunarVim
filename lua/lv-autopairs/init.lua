-- require('nvim-autopairs').setup()
-- local npairs = require('nvim-autopairs')

-- local function imap(lhs, rhs, opts)
--     local options = {noremap = false}
--     if opts then options = vim.tbl_extend('force', options, opts) end
--     vim.api.nvim_set_keymap('i', lhs, rhs, options)
-- end

-- _G.MUtils = {}

-- -- TEST
-- vim.g.completion_confirm_key = ""
-- MUtils.completion_confirm = function()
--     if vim.fn.pumvisible() ~= 0 then
--         if vim.fn.complete_info()["selected"] ~= -1 then
--             vim.fn["compe#confirm"]()
--             -- return npairs.esc("<c-y>")
--             return npairs.esc("")
--         else
--             vim.defer_fn(function()
--                 vim.fn["compe#confirm"]("<cr>")
--             end, 20)
--             return npairs.esc("<c-n>")
--         end
--     else
--         return npairs.check_break_line_char()
--     end
-- end
-- -- TEST

-- MUtils.completion_confirm = function()
--     if vim.fn.pumvisible() ~= 0 then
--         if vim.fn.complete_info()["selected"] ~= -1 then
--             vim.fn["compe#confirm"]()
--             return npairs.esc("")
--         else
--             vim.api.nvim_select_popupmenu_item(0, false, false, {})
--             vim.fn["compe#confirm"]()
--             return npairs.esc("<c-n>")
--         end
--     else
--         return npairs.check_break_line_char()
--     end
-- end

-- MUtils.tab = function()
--     if vim.fn.pumvisible() ~= 0 then
--         return npairs.esc("<C-n>")
--     else
--         if vim.fn["vsnip#available"](1) ~= 0 then
--             vim.fn.feedkeys(string.format('%c%c%c(vsnip-expand-or-jump)', 0x80, 253, 83))
--             return npairs.esc("")
--         else
--             return npairs.esc("<Tab>")
--         end
--     end
-- end

-- MUtils.s_tab = function()
--     if vim.fn.pumvisible() ~= 0 then
--         return npairs.esc("<C-p>")
--     else
--         if vim.fn["vsnip#jumpable"](-1) ~= 0 then
--             vim.fn.feedkeys(string.format('%c%c%c(vsnip-jump-prev)', 0x80, 253, 83))
--             return npairs.esc("")
--         else
--             return npairs.esc("<C-h>")
--         end
--     end
-- end

-- -- Autocompletion and snippets
-- vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', {expr = true, noremap = true})
-- -- imap("<CR>", "v:lua.MUtils.completion_confirm()", {expr = true, noremap = true})
-- imap("<Tab>", "v:lua.MUtils.tab()", {expr = true, noremap = true})
-- imap("<S-Tab>", "v:lua.MUtils.s_tab()", {expr = true, noremap = true})

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end


remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

require('nvim-treesitter.configs').setup {
    autopairs = {enable = true}
}

local ts_conds = require('nvim-autopairs.ts-conds')

-- press % => %% is only inside comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})
