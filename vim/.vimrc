
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin list
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'gmarik/Vundle.vim'
Plugin 'klen/python-mode'
Plugin 'kien/ctrlp.vim'
Plugin 'lyokha/vim-xkbswitch'           " Automatically switch from ru to us, when leaving insert mode
Plugin 'mhinz/vim-startify'             " Nice start screen
Plugin 'godlygeek/tabular'              " Alignment
Plugin 'tpope/vim-surround'
Plugin 'sjl/gundo.vim'                  " Visual undo tree
Plugin 'tpope/vim-unimpaired'           " Yes to square brackets!
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'                   " everything for golang
Plugin 'scrooloose/nerdcommenter'
Plugin 'marijnh/tern_for_vim'           " js completion
Plugin 'jelera/vim-javascript-syntax'   " js syntax and indentation
Plugin 'pangloss/vim-javascript'        " js highlight
Plugin 'Valloric/YouCompleteMe'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'ujihisa/nclipper.vim'
Plugin 'tpope/vim-jdaddy'               " json prettyfier
Plugin 'mileszs/ack.vim'
Plugin 'vim-scripts/IndexedSearch'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-vinegar'
Plugin 'dbakker/vim-projectroot'        " guessoing project root
" Plugin 'Raimondi/delimitMate'
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin list end
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""" Themes """"""""""""""""""""""""""""""
Plugin 'whatyouhide/vim-gotham'
Plugin 'sjl/badwolf'
Plugin 'fatih/molokai'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


call vundle#end()  

filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" YouCompleteMe
nmap gd :YcmCompleter GoToDefinition<CR> 
nmap <leader>d :YcmCompleter GoToDeclaration<CR> 
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

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_js_checkers = ['jshint']
let g:syntastic_html_checkers = ['tidy']
nmap gc :SyntasticCheck<CR> 

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

" Dispatch
nnoremap <F10> :Dispatch<CR>

" ack.vim
if executable('ag')
  let g:ackprg = 'ag'
endif
let g:ackhighlight = 1
nnoremap <Leader>f :ProjectRootExe Ack! --py '\b'<cword>'\b' <CR>
nnoremap <Leader>s :Ack! --py '\b'<C-R>=expand("<cword>")<CR>'\b' <C-R>=ProjectRootGuess()<CR>

" bufexplorer
let g:bufExplorerDisableDefaultKeyMapping=1    " Disable mapping.
nnoremap <silent> gb :BufExplorer<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings end
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ts=4 sts=4 sw=4 expandtab
if has("autocmd")

	autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab smarttab
	autocmd FileType javascript nmap gd :TernDef<CR>

	autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab smarttab
	autocmd FileType python nmap gd :YcmCompleter GoToDefinition<CR> 

	" Treat .rss files as XML
	autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

" Auto change the directory to the current file I'm working on
autocmd BufEnter * lcd %:p:h

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

colorscheme gotham "Цветовая схема
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
set undodir=$HOME/.vim/undo
set undolevels=10000
" How many lines
set undoreload=10000

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
