" Transform the data in the current buffer into xxd type.
function! xxd#apply()
  if &filetype != 'xxd'
    let b:initialfiletype = &filetype
    exec '%!xxd'
    let &filetype = 'xxd'
  endif
endfunction

" Revert a xxd buffer in bytes
function! xxd#revert()
  if &filetype == 'xxd'
    exec '%!xxd -r'
    let &filetype = b:initialfiletype
  endif
endfunction

" Updates content of current xxd buffer
function! xxd#update()
  let l:pos = getpos('.')
  if &filetype == 'xxd'
    call xxd#revert()
    call xxd#load()
    call setpos('.', l:pos)
  endif
endfunction

command Xxd :call xxd#apply()
command XxdRevert :call xxd#revert()
command XxdUpdate :call xxd#update()
