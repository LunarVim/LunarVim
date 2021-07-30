local keys = {}

keys.insert_mode = {}
-- keys.insert_mode["<C-Space>"] = { "compe#complete()", { noremap = true, silent = true, expr = true } }
-- keys.insert_mode["<CR>"] = { "compe#confirm('<CR>')", { noremap = true, silent = true, expr = true } }
-- keys.insert_mode["<C-e>"] = { "compe#close('<C-e>')", { noremap = true, silent = true, expr = true } }
-- keys.insert_mode["<C-f>"] = { "compe#scroll({ 'delta': +4 })", { noremap = true, silent = true, expr = true } }
-- keys.insert_mode["<C-d>"] = { "compe#scroll({ 'delta': -4 })", { noremap = true, silent = true, expr = true } }
-- keys.insert_mode["<Tab>"] = { "v:lua.tab_complete()", { expr = true } }
-- keys.insert_mode["<S-Tab>"] = { "v:lua.s_tab_complete()", { expr = true } }
--
keys.s_mode = {}
-- keys.s_mode["<S-Tab>"] = { "v:lua.s_tab_complete()", { expr = true } }
-- keys.s_mode["<Tab>"] = { "v:lua.tab_complete()", { expr = true } }

return keys
