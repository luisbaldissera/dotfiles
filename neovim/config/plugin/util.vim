" Create a directory if it does not exists. Similar to `mkdir -p`
function! util#createdir(directory)
  let l:directory = expand(a:directory)
  if !isdirectory(l:directory)
    call mkdir(l:directory, 'p', 0777)
    echomsg 'Directory created: ' . l:directory
  endif
endfunction

function! util#javapackage()
  let l:basepath = expand("%:p:h")
  let l:array = split(l:basepath, "/")
  let l:idx = index(l:array, "java")
  let l:package = join(l:array[l:idx+1:], ".")
  return l:package
endfunction
