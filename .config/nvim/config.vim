let s:configfile = $HOME . '/.config/nvim/config.json'
let s:config = json_decode(readfile(s:configfile))

let s:options = get(s:config, 'options', {})
let s:plugins = get(s:config, 'plugins', {})
let s:ui = get(s:config, 'ui', {})

" Helper functions {{{

" Set a Vim option for a given variable.
function! config#set(option, value)
  let l:value = a:value == v:false ? 0 : a:value == v:true ? 1 : string(a:value)
  execute 'let' '&' . a:option '=' l:value
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
" 
" E.g.: #{ number: v:true, expandtab: v:false, tabstop: 4 }
for [key, value] in items(s:options)
  call config#set(key, value)
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

" vim: foldmethod=marker
