call plug#begin('~/.local/share/nvim/plugged')
" zo： Open fold in current cursor postion
" zO： Open fold and sub-fold in current cursor postion recursively
" zc： Close the fold in current cursor position
" zC： Close the fold and sub-fold in current cursor position recursively
Plug 'tmhedberg/SimpylFold'

Plug 'preservim/nerdcommenter'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Common
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'liuchengxu/vim-which-key'
Plug 'voldikss/vim-floaterm'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'mhinz/vim-startify'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Python
Plug 'dense-analysis/ale', {'for': 'python'}

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Plug 'Xuyuanp/nerdtree-git-plugin'

" Themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'Luxed/ayu-vim'

call plug#end()
