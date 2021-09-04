command Xxd
  \ let b:previous_filetype = &filetype |
  \ exe '%!xxd' |
  \ let &filetype = 'xxd'

command XxdRevert
  \ exe '%!xxd -r' |
  \ let &filetype = b:previous_filetype
