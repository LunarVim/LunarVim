let g:asyncrun_open = 6
let g:asynctasks_term_pos = 'bottom'
" let g:asynctasks_term_pos = 'top'
" let g:asynctasks_term_pos = 'tab'
" let g:asynctasks_term_pos = 'external'
let g:asynctasks_extra_config = ['~/.config/nvim/utils/tasks.ini']
" let current_tasks = asynctasks#list("")

function! s:fzf_sink(what)
	let p1 = stridx(a:what, '<')
	if p1 >= 0
		let name = strpart(a:what, 0, p1)
		let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
		if name != ''
			exec "AsyncTask ". fnameescape(name)
		endif
	endif
endfunction

function! s:fzf_task()
	let rows = asynctasks#source(&columns * 48 / 100)
	let source = []
	for row in rows
		let name = row[0]
		let source += [name . '  ' . row[1] . '  : ' . row[2]]
	endfor
	let opts = { 'source': source, 'sink': function('s:fzf_sink'),
				\ 'options': '+m --nth 1 --inline-info --tac' }
	if exists('g:fzf_layout')
		for key in keys(g:fzf_layout)
			let opts[key] = deepcopy(g:fzf_layout[key])
		endfor
	endif
	call fzf#run(opts)
endfunction

command! -nargs=0 AsyncTaskFzf call s:fzf_task()

" Available Variables
" $(VIM_FILEPATH)    # File name of current buffer with full path.
" $(VIM_FILENAME)    # File name of current buffer without path.
" $(VIM_FILEDIR)     # Full path of current buffer without the file name.
" $(VIM_FILEEXT)     # File extension of current buffer.
" $(VIM_FILETYPE)    # File type (value of &ft in vim)
" $(VIM_FILENOEXT)   # File name of current buffer without path and extension.
" $(VIM_PATHNOEXT)   # Current file name with full path but without extension.
" $(VIM_CWD)         # Current directory (which :pwd returns).
" $(VIM_RELDIR)      # File path relativize to current directory.
" $(VIM_RELNAME)     # File name relativize to current directory.
" $(VIM_ROOT)        # Project root directory.
" $(VIM_CWORD)       # Word under cursor.
" $(VIM_CFILE)       # File name under cursor.
" $(VIM_CLINE)       # Cursor line number in current buffer
" $(VIM_GUI)         # has('gui_runnin')?
" $(VIM_VERSION)     # Value of v:version.
" $(VIM_COLUMNS)     # Current screen width.
" $(VIM_LINES)       # Current screen height.
" $(VIM_SVRNAME)     # Value of v:servername.
" $(VIM_PRONAME)     # Name of current project root directory
" $(VIM_DIRNAME)     # Name of current directory
" $(VIM_INIFILE)     # Full path name of current ini (.tasks) file.
" $(VIM_INIHOME)     # Where the ini file locates.
