let g:vimspector_install_gadgets = [
    \ 'vscode-cpptools',
    \ 'vscode-node-debug2'
    \ ]

nmap <leader>db <Plug>VimspectorToggleBreakpoint
nmap <leader>dd <Plug>VimspectorLaunch
nmap <leader>de <Plug>VimspectorEval
nmap <leader>di <Plug>VimspectorBalloonEval
nmap <leader>dn <Plug>VimspectorStepOver
nmap <leader>do <Plug>VimspectorShowOutput
nmap <leader>dq <Plug>VimspectorStop
nmap <leader>dr <Plug>VimpectorRestart
nmap <leader>dsi <Plug>VimspectorStepInto
nmap <leader>dso <Plug>VimspectorStepOut
nmap <leader>dw <Plug>VimspectorWatch

xmap <leader>di <Plug>VimspectorBalloonEval
