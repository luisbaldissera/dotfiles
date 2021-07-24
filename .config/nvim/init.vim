source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/plug-config/lightline.vim
source $HOME/.config/nvim/plug-config/fugitive.vim
source $HOME/.config/nvim/plug-config/gruvbox.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/telescope.vim
source $HOME/.config/nvim/plug-config/indentline.vim
source $HOME/.config/nvim/plug-config/git-gutter.vim
source $HOME/.config/nvim/plug-config/git-messenger.vim

" Moving lines
map <c-k> :move -2 .<cr>
map <c-j> :move +1 .<cr>

" Edit file under cursos in previous window
map <c-w>gp :let mycurf=expand("<cfile>")<cr>:winc p<cr>:execute("e ".mycurf)<cr>

" Tab managing
map <tab>n :tabnew .<cr>
map <tab>c :tabclose<cr>
map <tab>h :-tabmove<cr>
map <tab>l :+tabmove<cr>

" Line numbering
set number
set relativenumber

" Replace tabs by spaces
set expandtab

" Tab and indenting
augroup tabgroup
  autocmd!
  autocmd FileType c,cpp,java,python,vim,html,css,javascript,typescript,javascriptreact,typescriptreact,json,ruby,eruby setl tabstop=2 shiftwidth=2
  autocmd FileType sql setl tabstop=4 shiftwidth=4
augroup end

" Folding
augroup foldgroup
  autocmd!
  autocmd FileType git setl foldmethod=syntax
augroup end

" Color scheme
set termguicolors
set background=dark
colorscheme gruvbox


