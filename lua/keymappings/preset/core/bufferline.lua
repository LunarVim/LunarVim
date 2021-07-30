local keys = {}

keys.normal_mode = {}
keys.normal_mode["<S-x>"] = { ":BufferClose<CR>", { noremap = true, silent = true } }
keys.normal_mode["<S-l>"] = { ":BufferNext<CR>", { noremap = true, silent = true } }
keys.normal_mode["<S-h>"] = { ":BufferPrevious<CR>", { noremap = true, silent = true } }
keys.normal_mode["<leader>c"] = { ":BufferClose<CR>", { noremap = true, silent = true } }

return keys
