" Fugitive
nnoremap <silent> <leader>gs :Git<cr>:15winc _<cr>
nnoremap <silent> <leader>gd :Gdiffsplit<cr>
nnoremap <silent> <leader>gl :Git log<cr>
nnoremap <silent> <leader>gL :call fugitive#filelog()<cr>
nnoremap <silent> <leader>gb :Git blame<cr>

vnoremap <silent> <leader>gl <esc>:call fugitive#linelog()<cr>

" Git log of the lines in the selection
function! fugitive#linelog()
  let l:first = line("'<")
  let l:last = line("'>")
  let l:fname = expand('%')
  execute 'Git log -L ' . l:first . ',' . l:last . ':' . fname
endfunction

" Git log of the current file
function! fugitive#linelog()
  let l:fname = expand('%')
  execute 'Git log -- ' . l:fname
endfunction

" Do not show number side bar on fugitive and git related buffers.
augroup fugitive_custom
  autocmd!
  autocmd FileType fugitive,git setlocal nonumber norelativenumber
augroup end
