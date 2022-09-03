" Open the current file in VS Code
function! vscode#open()
  let l:goto = expand('%') . ':' . line('.') . ':' . col('.')
  execute "silent !code" shellescape(getcwd()) "--goto" shellescape(l:goto)
  redraw!
endfunction

command OpenInVSCode :call vscode#open()
