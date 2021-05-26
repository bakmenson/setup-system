let mapleader="\<Space>"

"map <leader>s :NERDTreeToggle<cr>
"map <F2> :NERDTreeToggle<cr>

""easymotion
"map <leader> <Plug>(easymotion-prefix)

"move lines
nnoremap <S-k> :m+<cr>
nnoremap <S-j> :m-2<cr>
xnoremap <S-k> :m-2<cr>gv=gv
xnoremap <S-j> :m'>+<cr>gv=gv

"keep text selected after indentation
vnoremap < <gv
vnoremap > >gv

""move between buffers
"nnoremap <leader>T :enew<cr>
"nnoremap <Tab> :bnext<cr>
"nnoremap <S-Tab> :bprevious<cr>
nnoremap <leader>bd :bp <bar> bd! #<cr>
"nnoremap <leader>bq :bufdo bd!<cr>
""cycle between last two open buffers
"nnoremap <leader><leader> <c-^>

"" close buffers without closing window
"map <leader>q :bp<bar>sp<bar>bn<bar>bd<cr>

"" moving between windows
"nnoremap <leader>h :wincmd h<cr>
"nnoremap <leader>j :wincmd j<cr>
"nnoremap <leader>l :wincmd l<cr>
"nnoremap <leader>k :wincmd k<cr>

"" split exists window
"nnoremap <C-l> :wincmd v<cr>
"nnoremap <C-j> :wincmd s<cr>

"nnoremap <silent> <Leader>\ :vertical resize +5<cr>
"nnoremap <silent> <Leader>- :vertical resize -5<cr>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"" Git
"nnoremap <leader>gs :G<cr>
"nnoremap <leader>gj :diffget //3<cr>
"nnoremap <leader>gf :diffget //2<cr>
"nnoremap <leader>gc :Gcommit<cr>

"" GitGutter
"nnoremap ]h <Plug>(GitGutterNextHunk)
"nnoremap [h <Plug>(GitGutterPreviewHunk)
"nnoremap ghs <Plug>(GitGutterStageHunk)
"nnoremap ghu <Plug>(GitGutterUndoHunk)

"" fzf.vim
"nnoremap <C-p> :GFiles<cr>
"nnoremap <C-f> :Files<cr>
"nnoremap <S-b> :Buffers<cr>

"" LSP keys
"nnoremap <leader>vd :lua vim.lsp.buf.definition()<cr>
"nnoremap <leader>vi :lua vim.lsp.buf.implementation()<cr>
"nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<cr>
"nnoremap <leader>vrr :lua vim.lsp.buf.references()<cr>
"nnoremap <leader>vrn :lua vim.lsp.buf.rename()<cr>
"nnoremap <leader>vh :lua vim.lsp.buf.hover()<cr>
"nnoremap <leader>vca :lua vim.lsp.buf.code_action()<cr>

""exit
"nnoremap <S-q> :q<cr>
