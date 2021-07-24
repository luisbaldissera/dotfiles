call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
  Plug 'airblade/vim-gitgutter'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/vim-peekaboo'
  Plug 'kshenoy/vim-signature'
  Plug 'leafgarland/typescript-vim'
  Plug 'lervag/vimtex'
  Plug 'liuchengxu/space-vim-theme'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'morhetz/gruvbox'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'pangloss/vim-javascript'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'rhysd/git-messenger.vim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'vim-ruby/vim-ruby'
  Plug 'will133/vim-dirdiff'
  Plug 'Yggdroot/indentLine'
call plug#end()

