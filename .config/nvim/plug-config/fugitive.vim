" Helper functions {{{

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

" TODO toggle git status
function! fugitive#togglestatus()
  topleft Git | execute "15wincmd _"
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
    execute 'close' bufwinnr('%')
  endif
endfunction

" }}}

" Show the git status
nnoremap <silent> <leader>gs :call fugitive#togglestatus()<cr>

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
"
" History of selected lines
vnoremap <silent> <leader>gL <esc>:'<,'>call fugitive#linelog()<cr>

" Do not show number side bar on fugitive and git related buffers.
augroup fugitive_custom
  autocmd!
  " Avoid showing number for fugitive and git buffers
  autocmd FileType fugitive,git setlocal nonumber norelativenumber
  " Automatically closes Git status fugitive window on leave
  autocmd BufLeave * :call fugitive#close()
augroup end

" vim: foldmethod=marker
