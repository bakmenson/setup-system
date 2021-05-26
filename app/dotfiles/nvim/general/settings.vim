"syntax on
syntax enable
set t_Co=256
filetype plugin on
set nocompatible
set background=dark
set tabstop=4
set shiftwidth=4
set softtabstop=4
set encoding=UTF-8
"set colorcolumn=120
set textwidth=120
set noswapfile
set number relativenumber
set termencoding=UTF-8
set fileencodings=UTF-8
set autoindent
set showmatch
set updatetime=50
set ttyfast
set ttimeout
set ttimeoutlen=50
set backspace=indent,eol,start whichwrap+=<,>,[,]
set showcmd
set wildmenu
set wildmode=longest:full,full
set hidden
set laststatus=2
set nowrap
set nopaste
set splitright
set smartcase
set ignorecase
set hlsearch
set incsearch
set nobackup
"set completeopt-=preview
set completeopt=menuone,noinsert,noselect
set complete=.,w,b,u,U,i,d
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
"set signcolumn=yes
set path+=**
set tags=./tags;/

"example for xfce4-terminal
set termguicolors

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" cd for current file
"autocmd BufEnter * silent! lcd %:p:h

" Python
" colorcolumn=80
autocmd Filetype python setlocal expandtab textwidth=79
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
