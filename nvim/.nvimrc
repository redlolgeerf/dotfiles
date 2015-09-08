" vim: set foldmethod=marker foldlevel=0:
call plug#begin('~/.nvim/plugged')

" ===================================================
" Plugin list {{{
" =================================================== 
Plug 'klen/python-mode'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm', { 'do': './install.sh' }
Plug 'lyokha/vim-xkbswitch'           " Automatically switch from ru to us, when leaving insert mode
Plug 'mhinz/vim-startify'             " Nice start screen
Plug 'godlygeek/tabular'              " Alignment
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'           " Yes to square brackets!
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'fatih/vim-go'                   " everything for golang
Plug 'scrooloose/nerdcommenter'
Plug 'marijnh/tern_for_vim'           " js completion
Plug 'jelera/vim-javascript-syntax'   " js syntax and indentation
Plug 'pangloss/vim-javascript'        " js highlight
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --gocode-completer' }
Plug 'mitsuhiko/vim-jinja'
Plug 'ujihisa/nclipper.vim'
Plug 'tpope/vim-jdaddy'               " json prettyfier
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/IndexedSearch'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'
Plug 'dbakker/vim-projectroot'        " guessing project root
Plug 'Raimondi/delimitMate'
Plug 'benekastah/neomake'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'gregsexton/gitv'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vasconcelloslf/vim-interestingwords'
"
" =================================================== }}}

" ===================================================
" {{{ Themes 
" ===================================================
Plug 'whatyouhide/vim-gotham'
Plug 'sjl/badwolf'
Plug 'fatih/molokai'
Plug 'christophermca/meta5'
" =================================================== }}}

call plug#end()

let maplocalleader = "\<Space>"
nnoremap <SPACE> <Nop>

" ===================================================
" {{{ Plugin settings
" ===================================================

" YouCompleteMe
nmap gd :YcmCompleter GoToDefinition<CR> 
nmap <LocalLeader>d :YcmCompleter GoToDeclaration<CR> 
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_goto_buffer_command = 'same-buffer'
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" XkbSwitch
let g:XkbSwitchEnabled = 1
let g:XkbSwitchLib = '/usr/lib/libxkbswitch.so'

let g:startify_custom_header = 
    \ map(split(system('fortune ~/.vim/fortunes | cowsay -W 60'), '\n'), '"   ". v:val') + ['','']

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsUsePythonVersion = 2
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" TagBar
nmap <F8> :TagbarToggle<CR>

" NerdTree
let NERDTreeWinPos = "right"
nmap <leader>t :NERDTreeToggle<CR> 
let g:NERDTreeWinPos = "right"
let NERDTreeIgnore = ['\.pyc$']

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0

" NerdCommenter
let g:NERDSpaceDelims = 1

" Pymode
let g:pymode_rope_completion = 0
let g:pymode_folding = 1
let g:pymode_options_colorcolumn = 1
let g:pymode_lint_on_fly = 0
let g:pymode_lint_on_write = 0
let g:pymode_lint_checkers = []
let g:pymode_rope_goto_definition_cmd = 'new'

" ack.vim
if executable('ag')
  let g:ackprg = 'ag'
endif
let g:ackhighlight = 1
nnoremap <LocalLeader>f :Ack! '\b'<C-R>=expand("<cword>")<CR>'\b' --<C-R>=&ft<CR> <C-R>=ProjectRootGuess()<CR><CR>
nnoremap <LocalLeader>s :Ack! '\b'<C-R>=expand("<cword>")<CR>'\b' --<C-R>=&ft<CR> <C-R>=ProjectRootGuess()<CR>
nnoremap <Leader>f :Ack! '\b'<C-R>=expand("<cword>")<CR>'\b' --<C-R>=&ft<CR> <C-R>=ProjectRootGuess()<CR>/../<CR>
nnoremap <Leader>s :Ack! '\b'<C-R>=expand("<cword>")<CR>'\b' --<C-R>=&ft<CR> <C-R>=ProjectRootGuess()<CR>/../

" bufexplorer
let g:bufExplorerDisableDefaultKeyMapping=1    " Disable mapping.
nnoremap <silent> gb :BufExplorer<CR>

" delimitMate
let g:delimitMate_expand_space=1
let g:delimitMate_expand_cr=1
 
" ctrlp
nmap <LocalLeader>b :CtrlPBuffer<CR>
let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" neomake
let g:neomake_go_enabled_makers = ['go']
let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_error_sign = {
    \ 'text': 'E>',
    \ 'texthl': 'ErrorMsg',
    \ }
let g:neomake_warning_sign = {
    \ 'text': 'W>',
    \ 'texthl': 'ErrorMsg',
    \ }
nmap <F7> :Neomake!<CR>

"
hi IndentGuidesOdd guibg=#11151c

" interestingwords
nnoremap <silent> <localleader>k :call InterestingWords('n')<cr>
nnoremap <silent> <localleader>K :call UncolorAllWords()<cr>
let g:interestingWordsRandomiseColors = 1
" =================================================== }}}

set ts=4 sts=4 sw=4 expandtab
if has("autocmd")

	autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab smarttab
	autocmd FileType javascript nmap gd :TernDef<CR>
	" autocmd FileType javascript call JavaScriptFold()

	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab smarttab
	autocmd FileType python nmap gd :YcmCompleter GoToDefinition<CR> 

	" Treat .rss files as XML
	autocmd BufNewFile,BufRead *.rss setfiletype xml
    au! BufReadPost {COMMIT_EDITMSG,*/COMMIT_EDITMSG} setl ft=gitcommit noml list| norm 1G

    autocmd BufWritePost *.go :Neomake!
    autocmd BufWritePost *.py :Neomake
    autocmd BufWritePost *.js :Neomake
endif

" " Auto change the directory to the current file I'm working on
" autocmd BufEnter * lcd %:p:h

" Always show statusline
set laststatus=2

"Автоотступ
set autoindent
"Подсвечиваем все что можно подсвечивать
let python_highlight_all = 1

"Вырубаем .swp и ~ (резервные) файлы
set nobackup
set noswapfile
set fileencodings=utf8,cp1251 " Возможные кодировки файлов, если файл не в unicode кодировке,
" то будет использоваться cp1251

set t_Co=256
set background=dark
if has("gui_running")
    colorscheme meta5
else
    colorscheme meta5
endif
set number "Включаем нумерацию строк
set cursorline "Включаем нумерацию строк
set mousehide "Спрятать курсор мыши когда набираем текст
set mouse=a "Включить поддержку мыши

syntax on

"font
if has('gui_running')
	set guifont=Firamono\ 12
endif

"отображение скрытых символов
if has('multi_byte')
	if version >= 700
		" set listchars=tab:»\ ,trail:·,eol:¶,extends:→,precedes:←,nbsp:×
		set listchars=tab:▸\ ,eol:¬
	else
		set listchars=tab:»\ ,trail:·,eol:¶,extends:>,precedes:<,nbsp:_
	endif
endif

autocmd BufWritePre *.py :call <SID>StripTrailingWhitespaces()
function! <SID>StripTrailingWhitespaces()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	%s/\s\+$//e
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

" Save the current buffer
imap <F6> <esc>:w<CR> a
nmap <F6> :w<CR>

"switching between tabs
nnoremap <F1> :tabprevious<CR>
nnoremap <F2> :tabnext<CR>
"open new tab
nnoremap <C-w>t :tabedit<CR>

" highlight collumn end for python files only
function! SetLimit() 
	setlocal colorcolumn=79
    highlight ColorColumn ctermbg=234 guibg=#1c1c1c
endfunction
autocmd FileType python call SetLimit()

"fixing backspace behavior
set backspace=2

" Don't try to highlight lines longer than 200 characters.
set synmaxcol=200

" Search options
set hlsearch " Highlight search results
set ignorecase " Ignore case in search patterns
set smartcase " Override the 'ignorecase' option if the search pattern contains upper case characters
set incsearch " While typing a search command, show where the pattern


set wildmenu " Better commandline completion
set wildmode=longest:full,full " Expand match on first Tab complete
set wildignore+=.hg,.git,.svn,*.pyc,.ropeproject
set wildcharm=<TAB> " Tab completion in command line mode
set showcmd

set hidden

fun! DetectTemplate()
	let n = 1
	while n < line("$")
		if getline(n) =~ '{%' || getline(n) =~ '{{'
			set ft=htmldjango
			return
		endif
		let n = n + 1
	endwhile
	set ft=html "default html
endfun
" autocmd BufNewFile,BufRead *.html call DetectTemplate()

" make hjkl movements accessible from insert mode via the <Ctrl> modifier key
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
inoremap <C-w> <C-o>w
inoremap <C-b> <C-o>b

if has('unnamedplus')
	" By default, Vim will not use the system clipboard when yanking/pasting to
	" the default register. This option makes Vim use the system default
	" clipboard.
	" Note that on X11, there are _two_ system clipboards: the "standard" one, and
	" the selection/mouse-middle-click one. Vim sees the standard one as register
	" '+' (and this option makes Vim use it by default) and the selection one as
	" '*'.
	" See :h 'clipboard' for details.
	set clipboard=unnamedplus,unnamed
else
	" Vim now also uses the selection system clipboard for default yank/paste.
	set clipboard+=unnamed
endif

" remove menu
set guioptions-=m
set guioptions-=T
set guioptions+=c

" remove scrollbar
set guioptions-=r
set guioptions-=L

set lazyredraw
set spelllang=ru_ru,en_us

" with this, we can now type ",." to exit out of insert mode
" if we really wanted to type ",.", then just type one char, wait half a sec,
" type another
inoremap ,. <Esc>
vnoremap ,. <Esc>

function! VisualSearch(direction) range
	let l:saved_reg = @"
	execute "normal! vgvy"
	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
		execute "Ack " . l:pattern . ' %'
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction "Basically you press * or # to search for the current selection

vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>

" This command will allow us to save a file we don't have permission to save
" *after* we have already opened it. Super useful.
cnoremap w!! w !sudo tee % >/dev/null

set cmdheight=2

nmap <leader>v :tabedit $MYVIMRC<CR>

" undo settings
set undofile
set undodir=$HOME/.nvim/undo
set undolevels=10000
" How many lines
" set undoreload=10000

set splitbelow
set splitright
set timeoutlen=450 
set iskeyword+=_

" Open file under cursor in a new vertical split
nnoremap gf :<C-u>vertical wincmd f<CR>

cabbrev Todo :tabedit $HOME/todo.txt

set ttimeoutlen=50  " Make Esc work faster

if v:version >= 704
  set regexpengine=1
endif

nmap <LocalLeader><Space> za
nmap <LocalLeader>h :noh<CR>

" terminal configuration
tnoremap <Esc> <C-\><C-n>
let g:terminal_scrollback_buffer_size = 100000
