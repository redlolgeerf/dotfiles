filetype plugin indent on

" let g:mapleader = "\<Space>"
let maplocalleader = "\<Space>"
nnoremap <SPACE> <Nop>

" Autoinstall vim-plug {{{
if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
"
" }}}

" {{{ Plugins
call plug#begin('~/.nvim/plugged') " Plugins initialization start 

" {{{ Themes
" ====================================================================
Plug 'whatyouhide/vim-gotham'
Plug 'sjl/badwolf'
Plug 'fatih/molokai'
Plug 'christophermca/meta5'
" }}}
" {{{  Appearance
" ====================================================================
Plug 'bling/vim-airline'
" {{{
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline_exclude_preview = 1

  " Tabline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 1
  let g:airline#extensions#tabline#show_tabs = 0
  let g:airline#extensions#tabline#fnamecollapse = 1
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#buffer_min_count = 2
" }}}
Plug 'nathanaelkane/vim-indent-guides'
" {{{
  let g:indent_guides_default_mapping = 0
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_exclude_filetypes = ['help', 'startify', 'man', 'rogue', 'term']
  hi IndentGuidesOdd guibg=#11151c
" }}}
Plug 'mhinz/vim-startify'
" {{{
  let g:startify_session_dir = '~/.nvim/session'
  let g:startify_list_order = ['files', 'dir', 'sessions']
  let g:startify_session_persistence = 1
  let g:startify_session_delete_buffers = 1
  let g:startify_change_to_dir = 1
  let g:startify_change_to_vcs_root = 1
  let g:startify_custom_header = 
        \ map(split(system('fortune ~/.vim/fortunes | cowsay -W 60'), '\n'), '"   ". v:val') + ['','']
  autocmd! User Startified setlocal colorcolumn=0
  " }}}
" }}}
" {{{ Completion
" ====================================================================
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --gocode-completer' }
" {{{
  nmap gd :YcmCompleter GoToDefinition<CR> 
  nmap <LocalLeader>d :YcmCompleter GoToDeclaration<CR> 
  let g:ycm_add_preview_to_completeopt = 1
  let g:ycm_autoclose_preview_window_after_insertion = 1
  let g:ycm_goto_buffer_command = 'same-buffer'
  let g:ycm_complete_in_comments = 1
  let g:ycm_collect_identifiers_from_comments_and_strings = 1

	autocmd FileType python nmap gd :YcmCompleter GoToDefinition<CR> 
" }}}
Plug 'SirVer/ultisnips'
" {{{
  let g:UltiSnipsExpandTrigger="<c-t>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
  let g:UltiSnipsUsePythonVersion = 2
  let g:UltiSnipsEditSplit="vertical"
" }}}
Plug 'honza/vim-snippets'
" }}}
" {{{ File Navigation
" ====================================================================
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm', { 'do': './install.sh' }
" {{{
  nmap <LocalLeader>b :CtrlPBuffer<CR>
  let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  nmap <LocalLeader>t :CtrlPBufTag<CR>
  nmap <Leader>t :CtrlPTag<CR>
" }}}
Plug 'scrooloose/nerdtree'
" {{{
  let NERDTreeWinPos = "right"
  nmap <leader>t :NERDTreeToggle<CR> 
  let g:NERDTreeWinPos = "right"
  let NERDTreeIgnore = ['\.pyc$']
" }}}
Plug 'dbakker/vim-projectroot'        " guessing project root
Plug 'mileszs/ack.vim'
" {{{
  if executable('ag')
    let g:ackprg = 'ag'
  endif
  let g:ackhighlight = 1
  nnoremap <LocalLeader>f :Ack! '\b'<C-R>=expand("<cword>")<CR>'\b'  <C-R>=ProjectRootGuess()<CR><CR>
  nnoremap <LocalLeader>s :Ack! '\b'<C-R>=expand("<cword>")<CR>'\b' <C-R>=ProjectRootGuess()<CR>
  nnoremap <Leader>f :Ack! '\b'<C-R>=expand("<cword>")<CR>'\b' <C-R>=ProjectRootGuess()<CR>/../<CR>
  nnoremap <Leader>s :Ack! '\b'<C-R>=expand("<cword>")<CR>'\b' <C-R>=ProjectRootGuess()<CR>/../
" }}}
Plug 'tpope/vim-vinegar'
" }}}
" {{{ Text Manipulation
" ====================================================================
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdcommenter'
" {{{
  let g:NERDSpaceDelims = 1
" }}}
"Plug 'Raimondi/delimitMate'
"" {{{
"  let g:delimitMate_expand_space=1
"  let g:delimitMate_expand_cr=1
"" }}}
" }}}
" {{{ Languages
" ====================================================================
Plug 'benekastah/neomake'
" {{{
  autocmd! BufWritePost * Neomake
  let g:neomake_airline = 0

  let g:neomake_error_sign = {
      \ 'text': 'E>',
      \ 'texthl': 'ErrorMsg',
      \ }
  let g:neomake_warning_sign = {
      \ 'text': 'W>',
      \ 'texthl': 'ErrorMsg',
      \ }
  nmap <F7> :Neomake!<CR>

  let g:neomake_go_enabled_makers = ['go']
  let g:neomake_python_enabled_makers = ['pylint']
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_javascript_jsx_enabled_makers = ['eslint']
" }}}
Plug 'majutsushi/tagbar'
" {{{
nmap <F8> :TagbarToggle<CR>
" }}}
" {{{ Python
Plug 'klen/python-mode'
" {{{
let g:pymode_rope_completion = 0
let g:pymode_folding = 1
let g:pymode_options_colorcolumn = 1
let g:pymode_lint_on_fly = 0
let g:pymode_lint_on_write = 0
let g:pymode_lint_checkers = []
let g:pymode_rope_goto_definition_cmd = 'new'

let python_highlight_all = 1

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
" }}}
Plug 'mitsuhiko/vim-jinja'
" }}}
" {{{ JavaScript
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
" {{{
let g:jsx_ext_required = 0
" }}}
Plug 'gavocanov/vim-js-indent'
Plug 'marijnh/tern_for_vim'
" {{{
autocmd FileType javascript nmap gd :TernDef<CR>
" }}}
" }}}
" {{{ HTML & CSS
Plug 'ap/vim-css-color'
Plug 'othree/html5.vim'
" }}}
" {{{ Go
Plug 'fatih/vim-go'
" }}}
" {{{ Rust
if executable('rustc')
  Plug 'wting/rust.vim'
  Plug 'racer-rust/vim-racer', { 'do': 'cargo build --release' }
  " {{{
  let g:racer_cmd = "/usr/bin/racer"
  let $RUST_SRC_PATH="/home/eyeinthebrick/rust/src"
endif
" }}}
" }}}
" {{{ Markup
Plug 'cespare/vim-toml'
" }}}
" }}}
" {{{ Git
" ====================================================================
Plug 'tpope/vim-fugitive'
" {{{
  " Fix broken syntax highlight in gitcommit files
  " (https://github.com/tpope/vim-git/issues/12)
  let g:fugitive_git_executable = 'LANG=en_US.UTF-8 git'
" }}}
Plug 'gregsexton/gitv'
Plug 'idanarye/vim-merginal'
" }}}
" {{{ Utility
" ====================================================================
Plug 'lyokha/vim-xkbswitch'
" {{{
  let g:XkbSwitchEnabled = 1
  let g:XkbSwitchLib = '/usr/lib/libxkbswitch.so'
" }}}
Plug 'ludovicchabant/vim-gutentags'
" {{{
  let g:gutentags_exclude = [
      \ '*.min.js',
      \ '*html*',
      \ 'jquery*.js',
      \ '*/vendor/*',
      \ '*/node_modules/*',
      \ ]

  let g:gutentags_ctags_executable_rs = 'rusty-tags vi'
  set tags=rusty-tags.vi;/,path-to-rust-source-code/rusty-tags.vi
  autocmd BufWrite *.rs :silent !rusty-tags vi &
" }}}
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'vasconcelloslf/vim-interestingwords'
" {{{
  nnoremap <silent> <localleader>k :call InterestingWords('n')<cr>
  nnoremap <silent> <localleader>K :call UncolorAllWords()<cr>
  let g:interestingWordsRandomiseColors = 1
" }}}
Plug 'takac/vim-hardtime'
" {{{
  let g:hardtime_default_on = 0
  let g:hardtime_ignore_quickfix = 1
  let g:hardtime_ignore_buffer_patterns = ['netrw', 'NERD.*', 'Tagbar', 'BufExplorer']
  let g:hardtime_allow_different_key = 1
" }}}
" Plug 'vim-scripts/IndexedSearch'
Plug 'vim-scripts/bufexplorer.zip'
" {{{
  let g:bufExplorerDisableDefaultKeyMapping=1    " Disable mapping.
  nnoremap <silent> gb :BufExplorer<CR>
" }}}
Plug 'kassio/neoterm'
" {{{
let g:neoterm_position = 'vertical'
let g:neoterm_raise_when_tests_fail = 1
" }}}
" }}}
" {{{ Misc
" ====================================================================
Plug 'vimwiki/vimwiki'
" }}}

call plug#end() " Plugins initialization finished }}}

" General settings {{{
" ====================================================================
syntax on " syntax highlighting

set clipboard=unnamed,unnamedplus
set number         " show line numbers
set noswapfile     " disable creating of *.swp files
set nobackup
set hidden         " hide buffers instead of closing
set lazyredraw     " speed up on large files
set mouse=         " disable mouse
set mousehide      " hide mouse

set virtualedit=onemore " allow the cursor to move just past the end of the line
set undofile
set undodir=$HOME/.nvim/undo
set undolevels=10000

" ! save global variables that doesn't contains lowercase letters
" h disable the effect of 'hlsearch' when loading the viminfo
" f1 store marks
" '100 remember 100 previously edited files
set viminfo=!,h,f1,'100

set foldmethod=manual       " use manual folding
set diffopt=filler,vertical " default behavior for diff

" ignore pattern for wildmenu
set wildignore+=.hg,.git,.svn,*.pyc,.ropeproject,*.pyc,*~,*.swp,*.tmp
set wildmode=list:longest,full
set wildmenu " Better commandline completion
set wildcharm=<TAB> " Tab completion in command line mode

set cmdheight=2

set listchars=tab:»\ ,trail:·,eol:¶,extends:>,precedes:<,nbsp:_

set laststatus=2 " always show status line
set showcmd      " always show current command

set nowrap        " disable wrap for long lines
set textwidth=0   " disable auto break long lines

set splitbelow
set splitright

set timeoutlen=450 
set iskeyword+=_

set backspace=2

set spelllang=ru_ru,en_us
" }}}
" Indentation {{{
" ====================================================================
set autoindent
" set expandtab     " replace <Tab with spaces
set tabstop=4     " number of spaces that a <Tab> in the file counts for
set softtabstop=4 " remove <Tab> symbols as it was spaces
set shiftwidth=4  " indent size for << and >>
set shiftround    " round indent to multiple of 'shiftwidth' (for << and >>)
autocmd FileType xml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 smarttab
autocmd FileType css setlocal ts=2 sts=2 sw=2 smarttab
autocmd FileType javascript setlocal ts=2 sw=2 smarttab expandtab
autocmd FileType javascript.jsx setlocal ts=2 sw=2 smarttab expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab smarttab
" }}}
" Search {{{
" ====================================================================
set ignorecase " ignore case of letters
set smartcase  " override the 'ignorecase' when there is uppercase letters
set incsearch  " While typing a search command, show where the pattern
set hlsearch   " Highlight search results
" }}}
" Colors and highlightings {{{
" ====================================================================
set background=dark
if has("gui_running")
    colorscheme meta5
else
    colorscheme meta5
endif

set cursorline     " highlight current line
set colorcolumn=80 " highlight column
highlight ColorColumn ctermbg=234 guibg=#1c1c1c
set synmaxcol=200

" Various columns
highlight! SignColumn ctermbg=233 guibg=#0D0D0D
highlight! FoldColumn ctermbg=233 guibg=#0D0D0D

" NeoMake
highlight! ErrorSign guifg=black guibg=#E01600 ctermfg=16 ctermbg=160
highlight! WarningSign guifg=black guibg=#FFED26 ctermfg=16 ctermbg=11

" }}}
" Key Mappings " {{{
nmap <leader>v :tabedit $MYVIMRC<CR>

" make hjkl movements accessible from insert mode via the <Ctrl> modifier key
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
inoremap <C-w> <C-o>w
inoremap <C-b> <C-o>b

" Save the current buffer
imap <F6> <esc>:w<CR> a
nmap <F6> :w<CR>

nmap <LocalLeader><Space> za

" Disable search highlighting
nmap <LocalLeader>h :noh<CR>

" Open file under cursor in a new vertical split
nnoremap gf :<C-u>vertical wincmd f<CR>

"switching between tabs
nnoremap <F1> :tabprevious<CR>
nnoremap <F2> :tabnext<CR>
"open new tab
nnoremap <C-w>t :tabedit<CR>

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
vnoremap <silent> gv :call VisualSearch('gv')<CR>
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" Remove trailing whitespaces in current buffer
nnoremap <Leader><BS>s :1,$s/[ ]*$//<CR>:nohlsearch<CR>1G
" }}}
" Terminal {{{
" ====================================================================
tnoremap <Esc> <C-\><C-n>
let g:terminal_scrollback_buffer_size = 100000
" }}}
" Autocommands {{{
" ====================================================================
augroup vimGeneralCallbacks
  autocmd!
  autocmd BufWritePost .nvimrc nested source ~/.nvimrc
augroup END

augroup fileTypeSpecific
  autocmd!
  " Rabl support
  autocmd BufRead,BufNewFile *.rabl setfiletype ruby
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
  " JST support
  autocmd BufNewFile,BufRead *.ejs set filetype=jst
  autocmd BufNewFile,BufRead *.jst set filetype=jst
  autocmd BufNewFile,BufRead *.djs set filetype=jst
  autocmd BufNewFile,BufRead *.hamljs set filetype=jst
  autocmd BufNewFile,BufRead *.ect set filetype=jst

  " Gnuplot support
  autocmd BufNewFile,BufRead *.plt set filetype=gnuplot

  autocmd FileType jst set syntax=htmldjango
augroup END

augroup quickFixSettings
  autocmd!
  autocmd FileType qf
        \ nnoremap <buffer> <silent> q :close<CR> |
        \ map <buffer> <silent> <F4> :close<CR> |
        \ map <buffer> <silent> <F8> :close<CR>
augroup END
"}}}
" Hacks {{{
set ttimeoutlen=50  " Make Esc work faster

if v:version >= 704
  set regexpengine=1
endif

noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>

" This command will allow us to save a file we don't have permission to save
" *after* we have already opened it. Super useful.
cnoremap w!! w !sudo tee % >/dev/null
" }}}
" GUI options {{{
  if has('gui_running')
    set guifont=Firamono\ 12
  endif

  " remove menu
  set guioptions-=m
  set guioptions-=T
  set guioptions+=c

  " remove scrollbar
  set guioptions-=r
  set guioptions-=L

"}}}

" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
