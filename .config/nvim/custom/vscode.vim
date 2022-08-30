" Open the current file in VS Code
function! vscode#open()
  let l:fname = expand('%')
  let l:line = line('.')
  let l:col = col('.')
  let l:cwd = getcwd()
  execute "silent !code " . l:cwd . " --goto '" . l:fname . ':' . l:line . ':' . l:col . "'"
  redraw!
endfunction

command OpenInVSCode :call vscode#open()
