tnoremap <Esc><Esc> <C-\><C-n>

augroup terminal_group
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup end
