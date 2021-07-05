---  HELPERS  ---

local cmd = vim.cmd
local opt = vim.opt

---  VIM ONLY COMMANDS  ---

cmd "filetype plugin on"
cmd('let &titleold="' .. TERMINAL .. '"')
cmd "set inccommand=split"
cmd "set iskeyword+=-"
cmd "set whichwrap+=<,>,[,],h,l"
if O.transparent_window then
  cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
  cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
end

--- COLORSCHEME ---

vim.g.colors_name = O.colorscheme

---  SETTINGS  ---

opt.backup = false -- creates a backup file
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
opt.colorcolumn = "99999" -- fix indentline for now
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.hidden = O.hidden_files -- required to keep multiple buffers and open multiple buffers
opt.hlsearch = O.hl_search -- highlight all matches on previous search pattern
opt.ignorecase = O.ignore_case -- ignore case in search patterns
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.pumheight = 10 -- pop up menu height
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 2 -- always show tabs
opt.smartcase = O.smart_case -- smart case
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = O.timeoutlen -- time to wait for a mapped sequence to complete (in milliseconds)
opt.title = true -- set the title of window to the value of the titlestring
opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
opt.undodir = CACHE_PATH .. "/undo" -- set an undo directory
opt.undofile = true -- enable persisten undo
opt.updatetime = 300 -- faster completion
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.shortmess:append "c"
opt.tabstop = 4 -- insert 4 spaces for a tab
opt.cursorline = O.cursorline -- highlight the current line
opt.number = O.number -- set numbered lines
opt.relativenumber = O.relative_number -- set relative numbered lines
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.wrap = O.wrap_lines -- display lines as one long line
