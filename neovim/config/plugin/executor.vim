" TODO: refactor this to make a plugin-like. Allowing also to do it per
" filetype
" 
" Requirements:
"   - For every filetype, if should allow:
"     - C-Enter: execute and move the cursor to the end
"     - C-Shift: execute and keep the cursor
"   - Always keep one session per file.
"   - Supported filetypes:
"     - Shell       (uses sh)
"     - Bash        (uses bash)
"     - Python      (uses python)
"     - Ruby        (uses irb)
"     - R           (uses rlang)
"     - JavaScript  (uses node)
"     - Java        (uses jshell)
"     - Vim         (uses execute())
"     - Lua         (uses ...)
"   - Future integration:
"     - Markdown:   (uses appropriate session based on ```{filetype})
"
vnoremap <C-Enter> ygvd:r!<C-R>"<Enter>
vnoremap <S-Enter> y`>:r!<C-R>"<Enter>
nnoremap <C-Enter> yy:r!<C-R>"<Enter>o<Esc>
nnoremap <S-Enter> mcyy:r!<C-R>"<Enter>`cmc
inoremap <C-Enter> <Esc>yy:r!<C-R>"<Enter>o
inoremap <S-Enter> <Esc>mcyy:r!<C-R>"<Enter>`cmca
