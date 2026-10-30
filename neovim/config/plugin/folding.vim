let g:xml_syntax_folding = 1

function! folding#foldtext()
  let l:custom = 'folding#foldtext#' . &filetype
  for custom in l:customs
    if exists(custom)
      return call(custom)
    endif
  endfor
  let l:firstline = getline(v:foldstart)
  let l:lastline = getline(v:foldend)
  return l:firstline . ' ⋯ ' . substitute(l:lastline, '^\s*', '', 'g')
endfunction
