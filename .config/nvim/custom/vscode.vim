" Open the current file in VS Code
function! vscode#open()
  let l:fname = expand('%')
  let l:line = line('.')
  let l:col = col('.')
  let l:cwd = getcwd()
  let l:goto = l:fname . ':' . l:line . ':' . l:col
  execute "silent !code" shellescape(l:cwd) "--goto" shellescape(l:goto)
  redraw!
endfunction

command OpenInVSCode :call vscode#open()
