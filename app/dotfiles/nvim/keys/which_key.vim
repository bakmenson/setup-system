
" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
	\| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" Single mappings
let g:which_key_map['.'] = [ ':e $MYVIMRC'                        , 'open init' ]
let g:which_key_map[','] = [ 'Buffers'                            , 'open buffers' ]
let g:which_key_map[';'] = [ ':Commands'                          , 'commands' ]
let g:which_key_map['q'] = [ 'q'                                  , 'quit' ]
let g:which_key_map['u'] = [ ':UndotreeToggle'                    , 'undo tree']
let g:which_key_map['i'] = [ '<Plug>(easymotion-prefix)'          , 'easymotion' ]

" Group mappings

let g:which_key_map['a'] = {
	\ 'name' : '+actions' ,
	\ 'c' : [':ColorizerToggle'                  , 'colorizer'],
	\ 'm' : [':MarkdownPreview'                  , 'markdown preview'],
	\ 'M' : [':MarkdownPreviewStop'              , 'markdown preview stop'],
	\ 'r' : [':source ~/dotfiles/nvim/init.vim'  , 'reload init.vim'],
	\ 's' : [':let @/ = ""'                      , 'remove search highlight'],
	\ }

let g:which_key_map['b'] = {
	\ 'name' : '+buffer' ,
	\ 'a' : [':bufdo bd!'  , 'kill all'],
	\ 'f' : ['bfirst'      , 'first-buffer'],
	\ 'h' : ['Startify'    , 'home-buffer'],
	\ 'l' : ['blast'       , 'last-buffer'],
	\ 'n' : ['bnext'       , 'next-buffer'],
	\ 'p' : ['bprevious'   , 'previous-buffer'],
	\ 'b' : ['Buffers'     , 'open buffers'],
	\ }

let g:which_key_map['f']= {
	\ 'name' : '+find & replace' ,
	\ 'b' : [':Farr --source=vimgrep'  , 'buffer'],
	\ 'p' : [':Farr --source=rgnvim'   , 'project'],
	\ 'f' : [':Files'                  , 'files'],
	\ 'g' : [':GFiles'                 , 'git files'],
	\ 'G' : [':GFiles?'                , 'modified git files'],
	\ 's' : [':w'                      , 'save'],
	\ }

let g:which_key_map['g'] = {
	\ 'name' : '+git' ,
	\ 'A' : [':Git add .'                        , 'add all'],
	\ 'a' : [':Git add %'                        , 'add current'],
	\ 'b' : [':Git blame'                        , 'blame'],
	\ 'c' : [':Gcommit'                          , 'commit'],
	\ 'd' : {
		\ 'name' : '+diff',
		\ 'j' : [':diffget //3'                    , 'diffget //3'],
		\ 'f' : [':diffget //2'                    , 'diffget //2'],
		\ },
	\ 'D' : [':Gdiffsplit'                       , 'diff split'],
	\ 'g' : [':GGrep'                            , 'git grep'],
	\ 's' : [':Gstatus'                          , 'status'],
	\ 'h' : [':GitGutterLineHighlightsToggle'    , 'highlight hunks'],
	\ 'H' : ['<Plug>(GitGutterPreviewHunk)'      , 'preview hunk'],
	\ 'i' : [':Gist -b'                          , 'post gist'],
	\ 'j' : ['<Plug>(GitGutterNextHunk)'         , 'next hunk'],
	\ 'k' : ['<Plug>(GitGutterPrevHunk)'         , 'prev hunk'],
	\ 'l' : [':Git log'                          , 'log'],
	\ 'm' : ['<Plug>(git-messenger)'             , 'message'],
	\ 'p' : [':Git push'                         , 'push'],
	\ 'P' : [':Git pull'                         , 'pull'],
	\ 'r' : [':GRemove'                          , 'remove'],
	\ 'G' : ['<Plug>(GitGutterStageHunk)'        , 'stage hunk'],
	\ 'S' : [':!git status'                      , 'status'],
	\ 't' : [':GitGutterSignsToggle'             , 'toggle signs'],
	\ 'u' : ['<Plug>(GitGutterUndoHunk)'         , 'undo hunk'],
	\ 'v' : [':GV'                               , 'view commits'],
	\ 'V' : [':GV!'                              , 'view buffer commits'],
	\ }

let g:which_key_map['G'] = {
	\ 'name' : '+gist' ,
	\ 'a' : [':Gist -a'                          , 'post gist anon'],
	\ 'b' : [':Gist -b'                          , 'post gist browser'],
	\ 'd' : [':Gist -d'                          , 'delete gist'],
	\ 'e' : [':Gist -e'                          , 'edit gist'],
	\ 'l' : [':Gist -l'                          , 'list public gists'],
	\ 's' : [':Gist -ls'                         , 'list starred gists'],
	\ 'm' : [':Gist -m'                          , 'post gist all buffers'],
	\ 'p' : [':Gist -P'                          , 'post public gist '],
	\ 'P' : [':Gist -p'                          , 'post private gist '],
	\ }

let g:which_key_map['k'] = {
	\ 'name' : '+task' ,
	\ 'c' : [':AsyncTask file-compile'      , 'compile file'],
	\ 'b' : [':AsyncTask project-build'     , 'build project'],
	\ 'e' : [':AsyncTaskEdit'               , 'edit local tasks'],
	\ 'f' : [':AsyncTaskFzf'                , 'find task'],
	\ 'g' : [':AsyncTaskEdit!'              , 'edit global tasks'],
	\ 'h' : [':AsyncTaskList!'              , 'list hidden tasks'],
	\ 'l' : [':CocList tasks'               , 'list tasks'],
	\ 'm' : [':AsyncTaskMacro'              , 'macro help'],
	\ 'o' : [':copen'                       , 'open task view'],
	\ 'r' : [':AsyncTask file-run'          , 'run file'],
	\ 'p' : [':AsyncTask project-run'       , 'run project'],
	\ 'x' : [':cclose'                      , 'close task view'],
	\ }

let g:which_key_map['p'] = {
	\ 'name' : '+project' ,
	\ 't' : [':MakeTags'                         , 'make tags'],
	\}

let g:which_key_map['r'] = {
	\ 'name' : '+run',
	\ 'p' : [':FloatermNew python %', 'run python'],
	\ 'n' : [':FloatermNew node %', 'run nodejs'],
	\}

let g:which_key_map['s'] = {
	\ 'name' : '+search' ,
	\ '/' : [':History/'              , 'history'],
	\ ';' : [':Commands'              , 'commands'],
	\ 'a' : [':Ag'                    , 'text Ag'],
	\ 'c' : [':Commits'               , 'commits'],
	\ 'C' : [':BCommits'              , 'buffer commits'],
	\ 'h' : [':History'               , 'file history'],
	\ 'H' : [':History:'              , 'command history'],
	\ 'l' : [':Lines'                 , 'lines'] ,
	\ 'm' : [':Marks'                 , 'marks'] ,
	\ 'M' : [':Maps'                  , 'normal maps'] ,
	\ 'p' : [':Helptags'              , 'help tags'] ,
	\ 'P' : [':Tags'                  , 'project tags'],
	\ 's' : [':CocList snippets'      , 'snippets'],
	\ 'S' : [':Colors'                , 'color schemes'],
	\ 't' : [':Rg'                    , 'text Rg'],
	\ 'T' : [':BTags'                 , 'buffer tags'],
	\ 'w' : [':Windows'               , 'search windows'],
	\ 'y' : [':Filetypes'             , 'file types'],
	\ 'z' : [':FZF'                   , 'FZF'],
	\ }
	" \ 's' : [':Snippets'     , 'snippets'],

let g:which_key_map['S'] = {
	\ 'name' : '+Session' ,
	\ 'c' : [':SClose'          , 'Close Session']  ,
	\ 'd' : [':SDelete'         , 'Delete Session'] ,
	\ 'l' : [':SLoad'           , 'Load Session']     ,
	\ 's' : [':Startify'        , 'Start Page']     ,
	\ 'S' : [':SSave'           , 'Save Session']   ,
	\ }

"let g:which_key_map['l'] = {
"	\ 'name' : '+lsp' ,
"	\ 'd' : [':lua vim.lsp.buf.definition()'      , 'definition'],
"	\ 'i' : [':lua vim.lsp.buf.implementation()'  , 'implementation'],
"	\ 's' : [':lua vim.lsp.buf.signature_help()'  , 'signature_help'],
"	\ 'r' : [':lua vim.lsp.buf.references()'      , 'references'],
"	\ 'R' : [':lua vim.lsp.buf.rename()'          , 'rename'],
"	\ 'h' : [':lua vim.lsp.buf.hover()'           , 'hover'],
"	\ 'c' : [':lua vim.lsp.buf.code_action()'     , 'code_action'],
"	\ }

let g:which_key_map['o'] = {
	\ 'name' : '+open' ,
	\ 'o' : [':Explore'   , 'open netrw'],
	\ 't' : [':Rexplore'  , 'open/close netrw'],
	\ }


let g:which_key_map['t'] = {
	\ 'name' : '+terminal' ,
	\ ';' : [':FloatermNew --wintype=normal --height=15'  , 'terminal'],
	\ 'f' : [':FloatermNew fzf'                           , 'fzf'],
	\ 'g' : [':FloatermNew lazygit'                       , 'git'],
	\ 'd' : [':FloatermNew lazydocker'                    , 'docker'],
	\ 'n' : [':FloatermNew node'                          , 'node'],
	\ 'p' : [':FloatermNew ipython'                       , 'ipython'],
	\ 'm' : [':FloatermNew lazynpm'                       , 'npm'],
	\ 'r' : [':FloatermNew ranger'                        , 'ranger'],
	\ 't' : [':FloatermToggle'                            , 'toggle'],
	\ 'y' : [':FloatermNew bashtop'                       , 'bashtop'],
	\ 's' : [':FloatermNew ncdu'                          , 'ncdu'],
	\ 'v' : [':FloatermNew vifm'                          , 'vifm'],
	\ }

let g:which_key_map['T'] = {
	\ 'name' : '+tabline' ,
	\ 'b' : [':XTabListBuffers'     , 'list buffers'],
	\ 'd' : [':XTabCloseBuffer'     , 'close buffer'],
	\ 'D' : [':XTabDeleteTab'       , 'close tab'],
	\ 'h' : [':XTabHideBuffer'      , 'hide buffer'],
	\ 'i' : [':XTabInfo'            , 'info'],
	\ 'l' : [':XTabLock'            , 'lock tab'],
	\ 'm' : [':XTabMode'            , 'toggle mode'],
	\ 'n' : [':tabNext'             , 'next tab'],
	\ 'N' : [':XTabMoveBufferNext'  , 'buffer->'],
	\ 't' : [':tabnew'              , 'new tab'],
	\ 'p' : [':tabprevious'         , 'prev tab'],
	\ 'P' : [':XTabMoveBufferPrev'  , '<-buffer'],
	\ 'x' : [':XTabPinBuffer'       , 'pin buffer'],
	\ }

let g:which_key_map['w'] = {
	\ 'name' : '+windows' ,
	\ 'w' : ['<C-W>w'     , 'other-window']          ,
	\ 'd' : ['<C-W>c'     , 'delete-window']         ,
	\ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
	\ 'h' : ['<C-W>h'     , 'window-left']           ,
	\ 'j' : ['<C-W>j'     , 'window-below']          ,
	\ 'l' : ['<C-W>l'     , 'window-right']          ,
	\ 'k' : ['<C-W>k'     , 'window-up']             ,
	\ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
	\ 'J' : [':resize +5' , 'expand-window-below']   ,
	\ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
	\ 'K' : [':resize -5' , 'expand-window-up']      ,
	\ '=' : ['<C-W>='     , 'balance-window']        ,
	\ 's' : ['<C-W>s'     , 'split-window-below']    ,
	\ 'v' : ['<C-W>v'     , 'split-window-right']    ,
	\ 'f' : ['Windows'    , 'fzf-window']            ,
	\ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
