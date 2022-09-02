let g:vimspector_base_dir = $HOME . '/.local/share/nvim/plugged/vimspector'

nnoremap <leader>db <Plug>VimspectorToggleBreakpoint
nnoremap <leader>dd <Plug>VimspectorLaunch
nnoremap <leader>de <Plug>VimspectorEval
nnoremap <leader>di <Plug>VimspectorBalloonEval
nnoremap <leader>dn <Plug>VimspectorStepOver
nnoremap <leader>do <Plug>VimspectorShowOutput
nnoremap <leader>dq <Plug>VimspectorStop
nnoremap <leader>dr <Plug>VimpectorRestart
nnoremap <leader>dsi <Plug>VimspectorStepInto
nnoremap <leader>dso <Plug>VimspectorStepOut
nnoremap <leader>dw <Plug>VimspectorWatch
xnoremap <leader>di <Plug>VimspectorBalloonEval
