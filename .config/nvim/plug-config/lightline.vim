" Light line
let g:lightline = {
	\ 'colorscheme': 'powerline',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
  \   'fugitive': '%{FugitiveStatusline()}',
	\   'cocstatus': 'coc#status'
	\ },
\ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
