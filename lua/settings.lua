-- TODO: REMOVE when https://github.com/neovim/neovim/pull/13479 comes

local opt = vim.opt

opt.iskeyword=opt.iskeyword + '-'            --treat dash separated words as a word text object"
-- opt.shortmess="c"                         --Don't pass messages to |ins-completion-menu|.

-- opt.formatoptions="cro"                   --Stop newline continution of comments
opt.hidden=true                           --Required to keep multiple buffers open multiple buffers
opt.wrap=false                            --Display long lines as just one line
--opt.whichwrap="+=<,>,[,],h,l"
opt.encoding="utf-8"                      --The encoding displayed
opt.pumheight=10                          --Makes popup menu smaller
opt.fileencoding="utf-8"                  --The encoding written to file
opt.ruler=true              		  --      --Show the cursor position all the time
opt.cmdheight=2                           --More space for displaying messages
opt.mouse="a"                             --Enable your mouse
opt.splitbelow=true                       --Horizontal splits will automatically be below
opt.termguicolors=true
opt.splitright=true                       --Vertical splits will automatically be to the right
opt.t_Co="256"                            --Support 256 colors
opt.conceallevel=0                        --So that I can see `` in markdown files
opt.tabstop=2                             --Insert 2 spaces for a tab
opt.shiftwidth=2                          --Change the number of space characters inserted for indentation
opt.smarttab=true                         --Makes tabbing smarter will realize you have 2 vs 4
opt.expandtab=true                        --Converts tabs to spaces
opt.smartindent=true                      --Makes indenting smart
opt.autoindent=true                       --Good auto indent
opt.laststatus=2                          --Always display the status line
opt.number=true                           --Line numbers
opt.cursorline=true                       --Enable highlighting of the current line
opt.background="dark"                     --tell vim what the background color looks like
opt.showtabline=2                         --Always show tabs
opt.showmode=false                        --We don't need to see things like -- INSERT -- anymore
opt.backup=false                          --This is recommended by coc
opt.writebackup=false                     --This is recommended by coc
opt.signcolumn="yes"                      --Always show the signcolumn, otherwise it would shift the text each time
opt.updatetime=300                        --Faster completion
opt.timeoutlen=1000                       --By default timeoutlen is 1000 ms
opt.clipboard="unnamedplus"               --Copy paste between vim and everything else
opt.incsearch=true
opt.guifont="JetBrainsMono\\ Nerd\\ Font\\ Mono:h18"
