nmap <C-a> <Plug>(dial-increment)
nmap <C-x> <Plug>(dial-decrement)
vmap <C-a> <Plug>(dial-increment)
vmap <C-x> <Plug>(dial-decrement)
vmap g<C-a> <Plug>(dial-increment-additional)
vmap g<C-x> <Plug>(dial-decrement-additional)

lua << EOF
local dial = require("dial")

dial.config.searchlist.normal = {
    "number#decimal",
    "number#hex",
    "number#binary",
    "date#[%Y/%m/%d]",
    "markup#markdown#header",
}
EOF
