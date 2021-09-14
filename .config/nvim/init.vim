source $HOME/.config/nvim/plugins.vim

source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/fake.vim
source $HOME/.config/nvim/plug-config/fugitive.vim
source $HOME/.config/nvim/plug-config/git-gutter.vim
source $HOME/.config/nvim/plug-config/git-messenger.vim
source $HOME/.config/nvim/plug-config/git-time-lapse.vim
source $HOME/.config/nvim/plug-config/gruvbox.vim
source $HOME/.config/nvim/plug-config/indentline.vim
source $HOME/.config/nvim/plug-config/lightline.vim
source $HOME/.config/nvim/plug-config/telescope.vim
source $HOME/.config/nvim/plug-config/theme.vim
source $HOME/.config/nvim/plug-config/vimspector.vim

" Moving lines
map <c-k> :move -2 .<cr>
map <c-j> :move +1 .<cr>
vmap <c-j> :m '>+1<CR>gv=gv
vmap <c-k> :m '<-2<CR>gv=gv

" Edit file under cursor in previous window
map <c-w>gp :let mycurf=expand("<cfile>")<cr>:winc p<cr>:execute("e ".mycurf)<cr>

source $HOME/.config/nvim/custom/bin.vim
source $HOME/.config/nvim/custom/fold.vim
source $HOME/.config/nvim/custom/options.vim
source $HOME/.config/nvim/custom/tabs.vim

