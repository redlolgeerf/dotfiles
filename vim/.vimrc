
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin list
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'gmarik/vundle' 
Plugin 'klen/python-mode' 
Plugin 'kien/ctrlp.vim' 
Plugin 'lyokha/vim-xkbswitch' " Automatically switch from ru to us, when leaving insert mode
Plugin 'mhinz/vim-startify' " Nice start screen
Plugin 'godlygeek/tabular' " Alignment
Plugin 'tpope/vim-surround'
Plugin 'sjl/gundo.vim' "Visual undo tree
Plugin 'tpope/vim-unimpaired' " Yes to square brackets!
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'majutsushi/tagbar' 
Plugin 'kien/rainbow_parentheses.vim' 
Plugin 'tpope/vim-fugitive'
"Plugin 'scrooloose/syntastic'
Plugin 'lambdalisue/vim-django-support'
Plugin 'scrooloose/nerdtree'
Plugin 'Raimondi/delimitMate'
Plugin 'sjl/badwolf'
Plugin 'fatih/molokai'
Plugin 'vim-scripts/dbext.vim' "plugin for working with sql
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go' "everything for golang
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()  

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" YouCompleteMe
nmap <leader>g :YcmCompleter GoToDefinition<CR> 
nmap <leader>d :YcmCompleter GoToDeclaration<CR> 
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insetion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_goto_buffer_command = 'new-tab'

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

" RainbowParentheses
nmap <F9> :RainbowParenthesesToggleAll<CR>
au VimEnter * RainbowParenthesesToggleAll
au VimEnter * RainbowParenthesesLoadRound
au VimEnter * RainbowParenthesesLoadSquare
au VimEnter * RainbowParenthesesLoadBraces

" Syntastic
let g:syntastic_python_checkers = ['flake8', 'pylama', 'pyflakes']
let g:syntastic_always_populate_loc_list = 1
nmap <leader>c :SyntasticCheck<CR> 

" NerdTree
let NERDTreeWinPos = "right"
nmap <leader>t :NERDTreeToggle<CR> 
let g:NERDTreeWinPos = "right"
let NERDTreeIgnore = ['\.pyc$']

" Dbext
let g:dbext_default_profile_sqlite_master = 'type=SQLITE:SQLITE_bin=sqlite3:dbname=~/Projects/hydra/db/main.sqlite'
let g:dbext_default_profile_sqlite_master_old = 'type=SQLITE:SQLITE_bin=sqlite3:dbname=~/Projects/hydra/db/main.sqlite.old'
let g:dbext_default_profile_sqlite_test = 'type=SQLITE:SQLITE_bin=sqlite3:dbname=~/dev/hydra/db/main.sqlite'

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0

" NerdCommenter
let g:NERDSpaceDelims = 1
" Pymode
let g:pymode_rope_completion = 0
let g:pymode_folding = 0
let g:pymode_options_colorcolumn = 1

set ts=4 sts=4 sw=4 expandtab
if has("autocmd")

	autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab smarttab

	" Treat .rss files as XML
	autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

" Always show statusline
set laststatus=2

"Автоотступ
set autoindent
"Подсвечиваем все что можно подсвечивать
let python_highlight_all = 1

"Вырубаем .swp и ~ (резервные) файлы
set nobackup
set noswapfile
set encoding=utf-8 " Кодировка файлов по умолчанию
set fileencodings=utf8,cp1251 " Возможные кодировки файлов, если файл не в unicode кодировке,
" то будет использоваться cp1251

"colorscheme badwolf "Цветовая схема
colorscheme molokai "Цветовая схема
set number "Включаем нумерацию строк
set cursorline "Включаем нумерацию строк
set mousehide "Спрятать курсор мыши когда набираем текст
set mouse=a "Включить поддержку мыши

"Включаем 256 цветов в терминале, мы ведь работаем из иксов?
"Нужно во многих терминалах, например в gnome-terminal
set t_Co=256
set background=dark
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
imap <F5> <esc>:w<CR>a
nmap <F5> :w<CR>

"switching between tabs
nnoremap <F1> :tabprevious<CR>
nnoremap <F2> :tabnext<CR>
"open new tab
nnoremap <C-w>t :tabedit<CR>

" highlight collumn end for python files only
function! SetLimit() 
	set colorcolumn=79
	highlight ColorColumn ctermbg=darkgray
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

" Tab completion in command line mode
set wildmenu " Better commandline completion
set wildmode=longest:full,full " Expand match on first Tab complete
set wildcharm=<TAB>

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
autocmd BufNewFile,BufRead *.html call DetectTemplate()

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
set undodir=$HOME/.vim/undo
set undolevels=1000
" How many lines
set undoreload=10000
