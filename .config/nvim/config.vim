let s:configfile = $HOME . '/.config/nvim/config.json'
let s:config = json_decode(readfile(s:configfile))

let s:options = get(s:config, 'options', {})
let s:plugins = get(s:config, 'plugins', {})
let s:ui = get(s:config, 'ui', {})

" Helper functions {{{

" Set a Vim option for a given variable.
function! config#set(option, value)
  let l:value = a:value ==# v:false ? 0 : a:value ==# v:true ? 1 : string(a:value)
  execute 'let' '&' . a:option '=' l:value
endfunction

" Set a Vim option globally and locally based on filetype.
function! config#setcustom(option, value)
  let l:global = get(a:value, 'global')
  let l:local = get(a:value, 'local', {})
  call config#set(a:option, l:global)
  for [key, value] in items(l:local)
    execute 'autocmd Filetype ' . key . ' let &l:' . a:option . ' = ' . string(value)
  endfor
endfunction

" Add Plug plugin and set related variables
" 
" E.g.:
"   config#plugin('Yggdroot/indentLine', {
"   \   'install': {
"   \     'branch': 'release'
"   \   },
"   \   'options': {
"   \     'g:indentLine_char': '|'
"   \   }
"   \ })
function! config#plugin(name, config)
  let l:install = get(a:config, 'install', {})
  let l:options = get(a:config, 'options', {})
  execute 'Plug' string(a:name) (l:install != {} ? ', ' . string(l:install) : '')
  for [key, value] in items(l:options)
    execute 'let' key '=' string(value)
  endfor
endfunction

" }}}

" Set Vim options from map
augroup config_vim_group
  autocmd!
  for [key, value] in items(s:options)
    " When it is a dict, set custom global and local
    if type(value) ==# type({})
      call config#setcustom(key, value)
    " Other wise, set regularly
    else
      call config#set(key, value)
    endif
  endfor

  " Set Vim Plug plugins from map and its configuration options.
  call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
    for [key, value] in items(s:plugins)
      call config#plugin(key, value)
    endfor
  call plug#end()

  " Set Ui configuration
  for [key, value] in items(s:ui)
    execute key value
  endfor
augroup end
