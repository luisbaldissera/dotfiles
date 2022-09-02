" Where the session file should be saved
let g:session_file = '.vim/session.vim'

" Only save sessions in git repositories
let g:session_should_save = isdirectory('.git')

" Load the session from the g:session_file if it exists
function! session#load()
  if filereadable(g:session_file)
    execute 'source ' . fnameescape(g:session_file)
  endif
endfunction

" Save the session in the g:session_file if g:session_should_save
function! session#store()
  let l:dir = fnamemodify(g:session_file, ':h')
  if g:session_should_save
    call mkdir(l:dir, 'p')
    execute 'mksession! ' . fnameescape(g:session_file)
  endif
endfunction

" Load and save session file automatically when entering and leaving vim.
augroup session_group
  autocmd!
  autocmd VimLeave * :call session#store()
  autocmd VimEnter * :call session#load()
augroup end


