nnoremap <leader>e :CocCommand explorer<cr>

" Helper functions {{{
function! coc#explorer#close()
  if &filetype ==# 'coc-explorer'
    execute 'close' bufwinnr('%')
  endif
endfunction
" }}}

augroup coc_explorer_custom
  autocmd!
  " Auto close coc-explorer when leaving the buffer
  autocmd BufLeave * :call coc#explorer#close()
augroup end

" vim: foldmethod=marker
