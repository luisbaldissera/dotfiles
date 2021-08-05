let g:indentLine_char = '|'

augroup tabgroup
  autocmd!
  autocmd FileType c,cpp,java,python,vim,html,css,javascript,typescript,javascriptreact,typescriptreact,json,ruby,eruby setl tabstop=2 shiftwidth=2
  autocmd FileType sql,sh,zsh setl tabstop=4 shiftwidth=4
augroup end

set expandtab

