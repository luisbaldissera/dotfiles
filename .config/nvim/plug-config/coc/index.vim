" Load Coc default extensions from JSON
let configfile = $HOME . '/.config/nvim/plug-config/coc/extensions.json'
let config = json_decode(readfile(configfile))
let extensions = config.extensions
let g:coc_global_extensions =
  \ map(extensions, {_, extension -> 'coc-' . extension})

source $HOME/.config/nvim/plug-config/coc/defaults.vim

source $HOME/.config/nvim/plug-config/coc/explorer.vim
source $HOME/.config/nvim/plug-config/coc/snippets.vim
source $HOME/.config/nvim/plug-config/coc/format-json.vim

