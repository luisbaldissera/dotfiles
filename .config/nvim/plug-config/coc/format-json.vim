" augroup format_json_group
"   autocmd!
"   autocmd BufWrite *.json let save = winsaveview() | CocCommand formatJson | winrestview(save)
" augroup end
