filetype plugin indent on

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
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
Plug 'morhetz/gruvbox'
" {{{
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
" }}}
Plug 'toupeira/vim-desertink'
Plug 'Nequo/vim-allomancer'
Plug 'Lokaltog/vim-monotone'
" }}}
" {{{  Appearance
" ====================================================================
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
  autocmd! User Startified setlocal colorcolumn=0
  " }}}
" }}}
" {{{ Completion
" ====================================================================
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" {{{
 let g:deoplete#enable_at_startup = 1
 set shortmess+=c
" }}}
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'go': ['go-langserver', '-gocodecompletion', '-lint-tool=golint'],
    \ 'javascript': ['node ~/bin/node_modules/javascript-typescript-langserver/lib/language-server.js'],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"Plug 'zchee/deoplete-jedi'
"" {{{
"  let deoplete#sources#jedi#show_docstring = 1
"" }}}
"Plug 'zchee/deoplete-go', { 'do': 'go get -u github.com/nsf/gocode && make'}
Plug 'Shougo/echodoc'
" {{{
set noshowmode
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
Plug 'nixprime/cpsm', { 'do': 'PY3=ON ./install.sh' }
" {{{
  let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }
" }}}
Plug 'scrooloose/nerdtree'
" {{{
  let NERDTreeWinPos = "right"
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
  nnoremap <LocalLeader>f :LAck! '\b<C-R>=expand("<cword>")<CR>\b'  <C-R>=ProjectRootGuess()<CR><CR>
  nnoremap <LocalLeader>s :LAck! '\b<C-R>=expand("<cword>")<CR>\b' <C-R>=ProjectRootGuess()<CR>
  nnoremap <Leader>f :LAck! '\b<C-R>=expand("<cword>")<CR>\b' <C-R>=expand('%:p:h')<CR><CR>
  nnoremap <Leader>s :LAck! '\b<C-R>=expand("<cword>")<CR>\b' <C-R>=expand('%:p:h')<CR>
" }}}
Plug 'tpope/vim-vinegar'
" }}}
" {{{ Text Manipulation
" ====================================================================
Plug 'Konfekt/FastFold'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdcommenter'
" {{{
  let g:NERDSpaceDelims = 1
" }}}
Plug 'wellle/targets.vim'
Plug 'jiangmiao/auto-pairs'
" {{{
  let g:AutoPairsFlyMode = 1
" }}}
" }}}
" {{{ Languages
" ====================================================================
" Plug 'w0rp/ale'
" " {{{
" let g:ale_linters = {'go': ['gofmt', 'golint', 'gometalinter'], 'python': ['pylint'], 'javascript': ['eslint']}
" let g:ale_python_pylint_executable = 'python2'
" let g:ale_python_pylint_options = '--rcfile ~/.config/pylintrc'
" " The virtualenv detection needs to be disabled.
" let g:ale_python_pylint_use_global = 0
" " }}}
Plug 'majutsushi/tagbar'
" {{{
nmap <F8> :TagbarToggle<CR>
" }}}
" {{{ Python
Plug 'klen/python-mode'
" {{{
let g:pymode_rope_completion = 0
let g:pymode_folding = 0
let g:pymode_options_colorcolumn = 1
let g:pymode_lint_on_fly = 0
let g:pymode_lint_on_write = 0
let g:pymode_lint_checkers = []
let g:pymode_rope_goto_definition_cmd = 'new'
let g:pymode_rope = 0

let g:pymode_syntax_slow_sync = 1
let python_highlight_all = 1

" }}}
Plug 'mitsuhiko/vim-jinja'
Plug 'kalekundert/vim-coiled-snake'
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
let g:go_version_warning = 0
let g:go_def_mapping_enabled = 0
" }}}
" {{{ Rust
if executable('rustc')
  Plug 'wting/rust.vim'
  Plug 'racer-rust/vim-racer', { 'do': 'cargo install racer' }
  " {{{
  let g:racer_cmd = "racer"
  let $RUST_SRC_PATH="/home/redlolgeerf/rust/src"
endif
" }}}
" }}}
" {{{ Markup
Plug 'cespare/vim-toml'
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
    UpdateRemotePlugins
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" }}}
" }}}
" {{{ Git
" ====================================================================
Plug 'tpope/vim-fugitive'
" {{{
" }}}
Plug 'shumphrey/fugitive-gitlab.vim'
" {{{
  let g:fugitive_gitlab_domains = ['http://gitlab.dev.ivi.ru/']
" }}}
Plug 'gregsexton/gitv'
Plug 'idanarye/vim-merginal'
Plug 'rhysd/git-messenger.vim'
" }}}
" {{{ Utility
" ====================================================================
Plug 'lyokha/vim-xkbswitch'
" {{{
  let g:XkbSwitchEnabled = 1
  " let g:XkbSwitchLib = '/usr/lib/libxkbswitch.so'
" }}}
Plug 'ludovicchabant/vim-gutentags'
" {{{
  let g:gutentags_ctags_exclude = [
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
  let g:interestingWordsGUIColors = ['#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF']
  let g:interestingWordsTermColors = ['154', '121', '125', '137', '214', '222']
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
let g:neoterm_default_mod = 'vertical'
let g:neoterm_raise_when_tests_fail = 1
" }}}
Plug 'brooth/far.vim'
" }}}
" {{{ Misc
" ====================================================================
Plug 'vimwiki/vimwiki'
" }}}

call plug#end() " Plugins initialization finished }}}

call deoplete#custom#source('_', 'matchers', ['matcher_cpsm'])
call deoplete#custom#source('_', 'sorters', [])

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

set foldmethod=syntax       " use manual folding
set diffopt=filler,vertical,internal,algorithm:histogram,indent-heuristic

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
" autocmd FileType html setlocal ts=2 sts=2 sw=2 smarttab
autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab smarttab
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
set inccommand=nosplit
" }}}
" Colors and highlightings {{{
" ====================================================================
set termguicolors
set background=dark
if has("gui_running")
    colorscheme meta5
else
    colorscheme monotone
endif

set showmatch      " show matching brackets
set cursorline     " highlight current line
set colorcolumn=80 " highlight column
highlight ColorColumn ctermbg=234 guibg=#1c1c1c
set synmaxcol=400

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
inoremap ,. <Esc>
vnoremap ,. <Esc>

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
" Abbreviations {{{
  abbreviate NOne None
"}}}


" let g:netrw_gx=substitute("<cfile>",'#','http://redmine.ivi.ru/issues/','g')
nmap <LocalLeader>r :call ViewInRedmine()<CR>
fun! ViewInRedmine()
    let keyword = expand("<cword>")
    let url = "http://redmine.ivi.ru/issues/" . keyword
    exec 'silent ! xdg-open ' . url
endfun

nmap <LocalLeader>j :call ViewInJira()<CR>
fun! ViewInJira()
    let keyword = expand("<cWORD>")
    let url = "https://jira.ivi.ru/browse/" . keyword
    exec 'silent ! xdg-open ' . url
endfun

set cursorline
autocmd VimEnter * NoMatchParen

set completefunc=LanguageClient#complete

autocmd BufWritePre :call <SID>StripTrailingWhitespaces()
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
" vim: set sw=2 ts=2 et foldlevel=0 foldmethod=marker:
