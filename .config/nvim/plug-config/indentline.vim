let g:indentLine_char = '|'

let g:indentLine_fileTypeExclude = [
  \ 'coc-explorer',
  \ 'help',
  \ 'terminal'
  \ ]

set tabstop=4 shiftwidth=4
augroup tabgroup
  autocmd!
  autocmd FileType arduino,lua,vim,c,cpp,python,vim,html,css,javascript,typescript,javascriptreact,typescriptreact,json,ruby,eruby setl tabstop=2 shiftwidth=2
augroup end

set expandtab

