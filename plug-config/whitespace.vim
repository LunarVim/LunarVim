function! <SID>StripTrailingWhitespaces()
  " save last search & cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

autocmd BufWritePre *.rb,*.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.jsx,*.js,*.ts,*.tsx call <SID>StripTrailingWhitespaces()
