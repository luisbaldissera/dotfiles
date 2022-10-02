" Use ripgrep if it is available
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

nnoremap <leader>s :set operatorfunc=grep#grep<Enter>g@
vnoremap <leader>s :<C-u>call grep#grep(visualmode())<Enter>

" Grep the content selected in visual mode or operator.
function! grep#grep(type)
  let l:previouscontent = @@

  if a:type ==# 'v'&& line("'<") ==# line("'>")
    normal! gvy
  elseif a:type ==# 'char'
    normal! `[y`]
  else
    return
  endif

  silent execute "grep! " . shellescape(@@)
  copen

  let @@ = l:previouscontent
endfunction

