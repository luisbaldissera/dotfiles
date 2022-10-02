" Show the git status
nnoremap <silent> <leader>gs :call fugitive#status()<cr>

" Show the git diff of the current file with HEAD
nnoremap <silent> <leader>gd :call fugitive#togglediff()<cr>

" Show the git logs
nnoremap <silent> <leader>gl :Git log<cr>

" Show the git blame
nnoremap <silent> <leader>gb :call fugitive#toggleblame()<cr>

" Show the git logs for the current file
nnoremap <silent> <leader>gf :call fugitive#filelog()<cr>

" History of current line
nnoremap <silent> <leader>gL <esc>:call fugitive#linelog()<cr>

" History of selected lines
vnoremap <silent> <leader>gl <esc>:'<,'>call fugitive#linelog()<cr>

" Helper functions {{{

" Git revert changes of the selection
function! fugitive#revertchanges() range
endfunction

" Git log of the lines in the selection
function! fugitive#linelog() range
  let l:arg = a:firstline . ',' . a:lastline . ':' . expand('%')
  execute 'Git log -L' shellescape(l:arg)
endfunction

" Git log of the current file
function! fugitive#filelog()
  let l:fname = expand('%')
  execute 'Git log --follow --' shellescape(l:fname)
endfunction

" Show git status in the top
function! fugitive#status() abort
  topleft Git
  15wincmd _
endfunction

" TODO toggle diff split
function! fugitive#togglediff()
  Gdiffsplit
endfunction

" TODO toggle git blame
function! fugitive#toggleblame()
  Git blame
endfunction

" Close the current buffer if it is fugitive
function! fugitive#close()
  if &filetype ==# 'fugitive'
    let b:fugitive_pos = getpos('.')
    execute 'close' bufwinnr('%')
  endif
endfunction

" }}}

augroup fugitive_custom
  autocmd!
  " Avoid showing number for fugitive and git buffers
  autocmd FileType fugitive,git setlocal nonumber norelativenumber
  " Automatically closes Git status fugitive window on leave
  autocmd BufLeave * :call fugitive#close()
augroup end

" vim: foldmethod=marker
