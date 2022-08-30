" Where the session file should be saved
let g:session_file = '.vim/session.vim'

" Only save sessions in git repositories
let g:session_should_save = isdirectory('.git')

function! session#load()
  if filereadable(g:session_file)
    execute 'source ' . g:session_file
  endif
endfunction

function! session#store()
  if g:session_should_save
    call mkdir(g:session_file, 'p')
    execute 'mksession! ' . g:session_file
  endif
endfunction

augroup session_group
  autocmd!
  autocmd VimEnter * :call session#load()
  autocmd VimLeave * :call session#store()
augroup end
