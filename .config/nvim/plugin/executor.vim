" C-Enter: execute and moce the cursor to the end
" C-Shift: execute and keep the cursor
vnoremap <C-Enter> ygvd:r!<C-R>"<Enter>
vnoremap <S-Enter> y`>:r!<C-R>"<Enter>
nnoremap <C-Enter> yy:r!<C-R>"<Enter>o<Esc>
nnoremap <S-Enter> mcyy:r!<C-R>"<Enter>`cmc
inoremap <C-Enter> <Esc>yy:r!<C-R>"<Enter>o
inoremap <S-Enter> <Esc>mcyy:r!<C-R>"<Enter>`cmca
