" Config File: $HOME/.config/nvim/config.json
let s:configfile = $HOME . '/.config/nvim/config.json'
let s:packpath = $HOME . '/.config/nvim/pack'
let s:config = json_decode(readfile(s:configfile))

let s:options = get(s:config, 'options', {})
let s:plugins = get(s:config, 'plugins', {})
let s:ui = get(s:config, 'ui', {})

" Helper functions {{{

" Set a Vim option for a given variable.
function! config#set(option, value)
  let l:val = config#resolveboolvalue(a:value)
  let l:val = config#resolveoptionvalue(a:option, l:val)
  execute 'let &' . a:option . ' = ' . string(l:val)
endfunction

" Resolve boolean values from JSON to actual values for vim
function config#resolveboolvalue(value)
  return a:value ==# v:false ? 0 : a:value ==# v:true ? 1 : a:value
endfunction

" Resolve some custom vim options when a string is more understandable than a
" single integer.
function! config#resolveoptionvalue(option, value)
  " l:cfg should be like: { [option]: { [string]: value } }
  let l:cfg = {
  \   'showtabline': {
  \     'default'                                  : 1 ,
  \     'never'                                    : 0 ,
  \     'always'                                   : 2 ,
  \     'only if there are at least two tab pages' : 1
  \   },
  \   'signcolumn': {
  \     '1'      : 'yes' ,
  \     '0'      : 'no'  ,
  \     'always' : 'yes' ,
  \     'never'  : 'no'
  \   }
  \ }
  let l:ret = a:value
  let l:custom = l:cfg->get(a:option, #{})
  if l:custom !=# #{}
    let l:ret = l:custom->get(a:value, a:value)
  endif
  return l:ret
endfunction

" Set a Vim option globally and locally based on filetype.
function! config#setcustom(option, value)
  let l:global = get(a:value, 'global')
  let l:local = get(a:value, 'local', {})
  call config#set(a:option, l:global)
  for [key, value] in items(l:local)
    " Supports shared values for multiple options separated with ','.
    for k in key->split(',')
      execute 'autocmd Filetype ' . k . ' let &l:' . a:option . ' = ' . string(config#resolveboolvalue(value))
    endfor
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
"   \   },
"   \   'map': {
"   \     'gd': 'GoToDefinitino'
"   \   }
"   \ })
function! config#plugin(name, config)
  let l:install = a:config->get('install', {})
  let l:options = a:config->get('options', {})
  let l:lua = a:config->get('lua', v:false)
  let l:map = a:config->get('map', {})
  execute 'Plug' string(a:name) (l:install != {} ? ', ' . string(l:install) : '')
  for [key, value] in l:options->items()
    execute 'let' key '=' string(value)
  endfor
  for [key, value] in l:map->items()
    execute 'nnoremap' key '<CMD>' . value . '<CR>'
  endfor
  " Configure Lua for plugin
  if has('nvim')
    " Normalize lua config to be a list
    if type(l:lua) ==# type({})
      let l:lua = [ l:lua ]
    endif
    if type(l:lua) ==# type([])
      for luaconfig in l:lua
        call v:lua.require('config').plugin_setup(luaconfig)
      endfor
    endif
  endif
endfunction

" }}}

" Set Vim options from map
augroup config_vim_group
  autocmd!
  for [key, value] in items(s:options)
    " Supports shared values for multiple options separated with ','.
    for k in key->split(',')
      " When it is a dict, set custom global and local
      if type(value) ==# type({})
        call config#setcustom(k, value)
      " Other wise, set regularly
      else
        call config#set(k, value)
      endif
    endfor
  endfor

  " [REMOVED] VimPlug: now moved to Lazy.nvim
  " TODO: Migrate the packages from config.json into Lazy.nvim

  " Set Ui configuration
  for [key, value] in items(s:ui)
    execute key value
  endfor
augroup end
