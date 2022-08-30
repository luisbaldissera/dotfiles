let mapleader = ','

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/plug-config/index.vim

" Moving lines
nnoremap <c-k> :move -2 .<cr>
nnoremap <c-j> :move +1 .<cr>
vnoremap <c-j> :move '>+1<cr>gv=gv
vnoremap <c-k> :move '<-2<cr>gv=gv

" Avoid using arrow keys. Those maps force to use hjkl movments.
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Edit file under cursor in previous window
nnoremap <c-w>gp :let mycurf=expand('<cfile>')<cr>:winc p<cr>:execute('edit ' . mycurf)<cr>

" Configure CTRL-G behavior
set shortmess=filmrnxtToOF

source $HOME/.config/nvim/custom/index.vim
