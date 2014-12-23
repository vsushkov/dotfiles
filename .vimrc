"
" My .vimrc
"
" Vundle {{{
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
    Plugin 'gmarik/vundle'
" like nocompatiable
    Plugin 'tpope/vim-sensible'
" My Bundles here:
    "Plugin 'tpope/vim-obsession'
    Plugin 'bling/vim-airline'
    Plugin 'scrooloose/nerdtree'
    Plugin 'vsushkov/nerdtree-ack'
    Plugin 'bkad/CamelCaseMotion'
    Plugin 'kien/ctrlp.vim'
    "Plugin 'tacahiroy/ctrlp-funky'
    "Plugin 'mattn/gist-vim'
    "Plugin 'mattn/webapi-vim'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'junegunn/vim-easy-align'
    Plugin 'tomtom/tlib_vim'
    Plugin 'tpope/vim-abolish'
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tpope/vim-git'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-surround'
    Plugin 'mileszs/ack.vim'
    Plugin 'mattn/emmet-vim'
    Plugin 'tpope/vim-fugitive'
    "Plugin 'gregsexton/gitv'
    "Plugin 'kablamo/vim-git-log'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'vimwiki/vimwiki'
    Plugin 'gregsexton/MatchTag'
    Plugin 'sjl/gundo.vim'
    "Plugin 'evanmiller/nginx-vim-syntax'
    Plugin 'tpope/vim-unimpaired'
    "Plugin 'tpope/vim-scriptease'
    "Plugin 'tpope/vim-eunuch'
    "Plugin 'kana/vim-textobj-user'
    "Plugin 'vim-scripts/scratch.vim'
    Plugin 'Raimondi/delimitMate'
    "Plugin 'terryma/vim-multiple-cursors'
    "Plugin 'mhinz/vim-signify'
" SnipMate
    Plugin 'garbas/vim-snipmate'
    Plugin 'honza/vim-snippets'
    Plugin 'vsushkov/my-snipmate-snippets'
" Coffescript / Javascript
    Plugin 'kchmck/vim-coffee-script'
    "Plugin 'itspriddle/vim-jquery'
    "Plugin 'AndrewRadev/vim-eco'
" JSON
    "Plugin 'leshill/vim-json'
" Ruby / Rails
    Plugin 'vim-ruby/vim-ruby'
    Plugin 'tpope/vim-endwise'
    Plugin 'tpope/vim-rails'
    "Plugin 'tpope/vim-bundler'
" Markups
    "Plugin 'tpope/vim-haml'
    Plugin 'tpope/vim-markdown'
    "Plugin 'othree/html5.vim'
    "Plugin 'avakhov/vim-yaml'
" PHP
    Plugin 'vsushkov/vim-phpdocumentor'
    Plugin 'vsushkov/vim-phpcs'
" SASS/SCSS/CSS
    "Plugin 'aaronjensen/vim-sass-status'
    "Plugin 'cakebaker/scss-syntax.vim'
    Plugin 'hail2u/vim-css3-syntax'
    Bundle 'groenewege/vim-less'
" Colorschemes
    Plugin 'jpo/vim-railscasts-theme'
    Plugin 'altercation/vim-colors-solarized'
    "Plugin 'sjl/badwolf'
    "Plugin 'tomasr/molokai'
" }}}
" Mappings {{{
" Leader
let mapleader = ","
let maplocalleader = "\\"

" Beatify XML
nmap <Leader>x :%s/></>\r</g<CR>gg=G

" Copy filepath to sysbuffer
nmap <Leader>p :let @+=expand("%")<CR>

noremap <F1> :set number!<CR>
noremap <F3> :make<CR>
noremap <F7> :!xmllint --noout %<CR>

" Keep search matches in the middle of the window and pulse the line when moving to them.
nnoremap n nzzzv
nnoremap N NzzzV
nnoremap * *zzzV
nnoremap # #zzzV
nnoremap g; g;zz
nnoremap g, g,zz

" Delete current buffer
nmap <D-d> :bd<CR>

" Quick jumping between splits
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
noremap <leader>v <C-w>v

map ì 10<C-W>>
map è 10<C-W><
map ë 5<C-W>-
map ê 5<C-W>+

map <S-Enter> O<Esc>j

" edit .vimrc
nmap <silent> ;v :next $MYVIMRC<CR>

" tmp file
nmap tt :next /tmp/temprary_file<CR>

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Switch off manual and help keys.
map K <nop>
imap <F1> <nop>
vmap K <nop>
vmap <F1> <nop>

" Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
vmap <BS> x

" Make vaa select the entire file...
vmap aa VGo1G

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" EMACS-like mappings:
imap <C-a> <C-c>A

" Don't use Ex mode; use Q for formatting
map Q gqj

nmap <Leader>c :e! ++enc=cp1251 ++ff=dos  <CR>

map Y y$

vnoremap <silent> <Enter> :EasyAlign<cr>

autocmd BufReadPost *.css,*.scss nnoremap <buffer> <D-j> :%s/\(\w\):\(\S\)/\1: \2/g<CR>
autocmd BufReadPost *.css,*.scss nnoremap <buffer> <D-k> :%s/\(\S\){/\1 {/g<CR>

" }}}
" Functions {{{
" remove trailing spaces before save
fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun

function! SendToTerminal(args)
    execute ":silent !run_command '" . a:args . "'"
endfunction

function! ClearTerminal()
    call SendToTerminal("clear")
endfunction

function! RSpec()
    call ClearTerminal()
    if exists("s:current_test")
        call SendToTerminal("rspec -fd " . s:current_test)
    endif
endfunction

function! PHPUnit()
    call ClearTerminal()
    if exists("s:current_test")
        call SendToTerminal("phpunit " . s:current_test)
    endif
endfunction

function! RunCurrentTest()
    if exists('b:isPHP')
        " Coding is requred here
        let s:current_test = 'UnitTests.php'
        call PHPUnit()
    else
        let s:current_test = expand('%:p')
        call RSpec()
    endif
endfunction

function! RunCurrentLineInTest()
    let s:current_test = expand('%:p') . ":" . line('.')
    call RSpec()
endfunction

function! RunLastCommand()
    call RSpec()
endfunction

" }}}
" Plugins settings {{{

" Coffe
let coffee_compile_vert = 1

" Airline
let g:airline_theme = 'monochrome'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" NERDTree
let g:NERDChristmasTree = 1
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 30
let g:NERDTreeCaseSensitiveSort = 1
let g:NERDTreeChDirMode = 2
map <F4> :NERDTreeToggle <cr>
map <Leader>r :NERDTreeFind <cr>

" Fugitive
map <leader>gs :Gstatus<cr>
map <leader>gw :Gwrite<cr>
map <leader>gd :Gdiff<cr>
map <leader>gc :Gcommit<cr>
map <leader>gb :Gblame<cr>
map <leader>gl :Glog

" PHP Documentor settings
let g:pdv_cfg_php4always = 0
nmap <Leader>d :call PhpDocSingle()<CR>

" CtrlP
let g:ctrlp_max_files = 30000
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|var$\|downloader$\|errors$\|pkginfo$\|media$',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|.jpg$\|\.gif$\|\.png$\|\.alist$\|\.clist$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_extensions = ['funky']

" Easymotion settings
let g:EasyMotion_leader_key = '<Leader>'

" VimWiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'ext': '.wiki'}]
let g:vimwiki_ext2syntax = {'.wiki': 'media'}

" SnipMate settings
let g:snipMate = {}
let g:snipMate['snippet_dirs'] = ['/Users/vsushkov/.vim/bundle/vim-snippets', '/Users/vsushkov/.vim/bundle/my-snipmate-snippets']
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['php'] = 'php'
let g:snipMate.scope_aliases['phtml'] = 'php,html,javascript'
let g:snipMate.scope_aliases['scss'] = 'scss,css'

" NERDCommenter for ruby
let g:NERDCustomDelimiters = {
    \ 'ruby': { 'left': '# ' }
\ }

" Gundo
nnoremap <F5> :GundoToggle<CR>
let g:gundo_right = 1

" PHPCS
noremap <F6> :Phpcs<CR>

" Gist
let g:gist_clip_command = 'pbcopy'
let g:gist_open_browser_after_post = 1

" Ack / Ag
let g:ackprg = 'ag --nogroup --column -a -S --nocolor --follow'

" Abolish
let g:abolish_save_file = $HOME . '/dotfiles/abolish.vim'

" Signify
let g:signify_vcs_list = ['git']

" }}}
" Settings {{{
set encoding=utf-8  " Necessary to show unicode glyphs
set tabstop=4       " numbers of spaces of tab character
set softtabstop=4
set shiftwidth=4    " numbers of spaces to (auto)indent
set scrolloff=3     " keep 3 lines when scrolling
set hlsearch        " highlight searches
set noerrorbells
set visualbell t_vb=    " turn off error beep/flash
set nonumber        " do not show line numbers
set ignorecase
set smartcase       " smart case when searching
set title           " Set the terminal title
set nowrap
set expandtab
set autoread        " When a file has been changed outside of Vim, automatically read it again
set formatoptions+=t
set notitle
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set foldmethod=marker
set ch=1 " Command line height
set nobackup
set nowritebackup
set noswapfile
set backupdir=~/tmp
set shell=/usr/local/bin/zsh\ -l
set list
set ff=unix
set synmaxcol=200
set diffopt=filler,vertical

" Don't update the display while executing macros
set lazyredraw

" Don't show the current command in the lower right corner. In OSX, if this is
" set and lazyredraw is set then it's slow as molasses, so we unset this
" set noshowcmd

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
set timeoutlen=500
set matchtime=1

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Use persistent undo
if has('persistent_undo')
    set undodir=/tmp
    set undolevels=5000
    set undofile
endif

" Use option (alt) as meta key.
if has('mac')
    set macmeta
endif
" }}}
" Autocommands {{{
autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
autocmd FileType php setlocal ai sw=4 sts=4 et tw=120
autocmd FileType php let b:isPHP=1
autocmd FileType phtml setlocal ai sw=4 sts=4 et tw=0
autocmd FileType gitcommit setlocal colorcolumn=50,72 tw=72
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
autocmd BufNewFile,BufReadPost *.phtml setl filetype=phtml
autocmd BufNewFile,BufReadPost *.md setl filetype=markdown
autocmd BufNewFile,BufReadPost *.cnf setl filetype=dosini
" autocmd BufWritePost *.md,*.markdown :silent !cat %:p | curl -X PUT -T - http://localhost:8090/
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType ruby,markdown,yaml let b:noStripWhitespace=1
autocmd FileType ruby compiler ruby
autocmd FileType eruby compiler eruby
autocmd FileType css setlocal sw=2 sts=2 ts=2 ai et
autocmd FileType scss setlocal sw=2 sts=2 ts=2 ai et
" apply .vimrc after save
autocmd BufWritePost .vimrc source %
" Save when losing focus
autocmd FocusLost * :wa
" Resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="
" }}}
" Not sorted {{{
" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END
" }}}
" GUI {{{
if has("gui_running")
    let g:solarized_diffmode="high"

    set lines=59
    set columns=272
    set background=light
    set guifont=Monaco:h12

    if (filereadable("Gemfile") || filereadable("Rakefile")) && !filereadable('index.php')
        colorscheme railscasts
        set number
        set guifont=Monaco:h13
    else
        colorscheme solarized
        "colorscheme badwolf
        call togglebg#map("<F12>")
    endif

    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar

    " no search highlight
    noremap <M-/> :nohl<CR>
    " fugitive
    noremap <M-g> :Git<Space>

    if exists('+colorcolumn')
         set colorcolumn=+1
    endif
endif
" }}}
