local keys = {}

keys.insert_mode = {}
keys.insert_mode["<C-Space>"] = { "compe#complete()", { noremap = true, silent = true, expr = true } }
-- keys.insert_mode["<CR>"] = { "compe#confirm('<CR>')", { noremap = true, silent = true, expr = true } }
keys.insert_mode["<C-e>"] = { "compe#close('<C-e>')", { noremap = true, silent = true, expr = true } }
keys.insert_mode["<C-f>"] = { "compe#scroll({ 'delta': +4 })", { noremap = true, silent = true, expr = true } }
keys.insert_mode["<C-d>"] = { "compe#scroll({ 'delta': -4 })", { noremap = true, silent = true, expr = true } }

return keys
