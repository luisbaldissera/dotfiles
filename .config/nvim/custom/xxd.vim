function! xxd#apply()
  if &filetype != 'xxd'
    let b:initialfiletype = &filetype
    exec '%!xxd'
    let &filetype = 'xxd'
  endif
endfunction

function! xxd#revert()
  if &filetype == 'xxd'
    exec '%!xxd -r'
    let &filetype = b:initialfiletype
  endif
endfunction

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
