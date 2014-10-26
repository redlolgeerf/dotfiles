set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle' 

Plugin 'Valloric/YouCompleteMe'

Plugin 'kien/ctrlp.vim' 

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
"
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsUsePythonVersion = 2

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

Plugin 'majutsushi/tagbar' 
nmap <F8> :TagbarToggle<CR>

Plugin 'kien/rainbow_parentheses.vim' 
nmap <F9> :RainbowParenthesesToggleAll<CR>
au VimEnter * RainbowParenthesesToggleAll
au VimEnter * RainbowParenthesesLoadRound
au VimEnter * RainbowParenthesesLoadSquare
au VimEnter * RainbowParenthesesLoadBraces

Plugin 'tpope/vim-fugitive'

Plugin 'davidhalter/jedi-vim'
"no autocompletion
let g:jedi#completions_enabled = 0

Plugin 'scrooloose/syntastic'
let g:syntastic_python_checkers = ['pylint', 'pylama', 'pep8', 'flake8', 'pyflakes']
let g:syntastic_always_populate_loc_list = 1
nmap <leader>c :SyntasticCheck<CR> 

Plugin 'lambdalisue/vim-django-support'

Plugin 'scrooloose/nerdtree'
"open NerdTree with leader+t
nmap <leader>t :NERDTreeToggle<CR> 

Plugin 'Raimondi/delimitMate'

Plugin 'sjl/badwolf'
"Plugin 'vim-scripts/desert.vim', {'rtp': 'colors/'}

"plugin for indentation line
Plugin 'Yggdroot/indentLine'

"plugin for working with sql
Plugin 'vim-scripts/dbext.vim'
" SQLite
let g:dbext_default_profile_sqlite_master = 'type=SQLITE:SQLITE_bin=sqlite3:dbname=~/Projects/hydra/db/main.sqlite'
let g:dbext_default_profile_sqlite_master_old = 'type=SQLITE:SQLITE_bin=sqlite3:dbname=~/Projects/hydra/db/main.sqlite.old'
let g:dbext_default_profile_sqlite_test = 'type=SQLITE:SQLITE_bin=sqlite3:dbname=~/dev/hydra/db/main.sqlite'

Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
set rtp+=$HOME/.vim/bundle/powerline/powerline/lib/python2.7/site-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2
" scripts from http://vim-scripts.org/vim/scripts.html
Plugin 'scrooloose/nerdcommenter'

call vundle#end()  
filetype plugin on
filetype plugin indent on

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab "Ставим табы пробелами
set softtabstop=4 "4 пробела в табе
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

"Вырубаем .swp и ~ (резервные) файлы
set nobackup
set noswapfile
set encoding=utf-8 " Кодировка файлов по умолчанию
set fileencodings=utf8,cp1251 " Возможные кодировки файлов, если файл не в unicode кодировке,
" то будет использоваться cp1251

colorscheme badwolf "Цветовая схема
set nu "Включаем нумерацию строк
set mousehide "Спрятать курсор мыши когда набираем текст
set mouse=a "Включить поддержку мыши

"сокращение для добавления кодировки
iab bin! #! /usr/bin/env python3
iab utf! # -*- coding: utf-8 -*-
iab main! if __name__ == '__main__':
"
"Включаем 256 цветов в терминале, мы ведь работаем из иксов?
"Нужно во многих терминалах, например в gnome-terminal
set t_Co=256
set background=dark
syntax on

"font
if has('gui_running')
    set guifont=Inconsolata\ 12
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
nmap <leader>h :set list!<CR>

" Save the current buffer
imap <F5> <esc>:w<CR>a
nmap <F5> :w<CR>

"switching between tabs
nnoremap <F1> :tabprevious<CR>
nnoremap <F2> :tabnext<CR>
"open new tab
nnoremap <C-w>t :tabedit<CR>

" highlight collumn end for python files only
function SetLimit()
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

"show diff from previously saved version
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis
nmap <leader>p :DiffOrig<CR>

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

" make hjkl movements accessible from insert mode via the <Alt> modifier key
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
inoremap <C-w> <C-o>w
inoremap <C-b> <C-o>b

" Use the OS clipboard by default
set clipboard=unnamed

" remove menu
set guioptions-=m
set guioptions-=T

set spelllang=ru_ru,en_us
nmap <F6> :set spell<CR>
