"Place for me to test things"

let s:menus = {}
let s:menus.denite = { 'description': 'denite commands' }
let s:menus.denite.command_candidates = [
\ ['> file_rec',          'Denite file_rec'],
\ ['> file_mru',          'Denite file_mru'],
\ ]

call denite#custom#var('menu', 'menus', s:menus)

function Command ()
    set wrap
    set nobuflisted
    :pedit ~/.config/nvim/commands/leadercommands.txt
    
endfunction
 
nmap <silent>  <C-B>  :call SaveBackup()<CR>
