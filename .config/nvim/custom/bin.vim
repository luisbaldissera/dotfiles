" Transform the current buffer in xxd
command Xxd
  \ let b:xxd_previous_filetype = &filetype |
  \ exe '%!xxd' |
  \ let &filetype = 'xxd'

" Transform back the current xxd buffer in regular file
command XxdRevert
  \ exe '%!xxd -r' |
  \ let &filetype = get(b:, 'xxd_previous_filetype', &filetype)

" Update current xxd buffer. If you made changes on the hexadecimal,
" the changes will be applied to the right characters
command XxdUpdate
  \ let b:xxd_previous_cursor_position = getpos('.') |
  \ exe 'XxdRevert' |
  \ exe 'Xxd' |
  \ call setpos('.', b:xxd_previous_cursor_position)
