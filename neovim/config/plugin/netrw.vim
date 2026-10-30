let g:netrw_banner          = 0
let g:netrw_keepdir         = 1
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_winsize         = 30
let g:netrw_liststyle       = 3

function! g:CopyCurrentPath()
  let @+ = expand('%')
  echom '"' .. @+ ..'" copied to clipboard'
endfunction

command CopyCurrentPath :call g:CopyCurrentPath()
