let g:coc_global_extensions = ['coc-snippets', 'coc-vimlsp', 'coc-explorer', 'coc-json']
if isdirectory('./node_modules')
  let g:coc_global_extensions += ['coc-tsserver']
  if isdirectory('./node_modules/prettier')
    let g:coc_global_extensions += ['coc-prettier']
  endif
  if isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
  endif
endif
if filereadable('./Gemfile')
  let g:coc_global_extensions += ['coc-solargraph']
endif
if filereadable('./pom.xml')
  let g:coc_global_extensions += ['coc-java']
endif
if filereadable('./main.tex')
  let g:coc_global_extensions += ['coc-vimtex']
endif


