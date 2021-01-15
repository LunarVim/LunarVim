function! GDiffCompare()
  call inputsave()
  let args = input('Compare with branch: ')
  call inputrestore()
  execute ':Gvdiffsplit '..args..':%'
endfunction
