"
" My .vimrc
"
" Vundle {{{
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
    Bundle 'gmarik/vundle'

" My Bundles here:
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'jpo/vim-railscasts-theme'
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'mrtazz/molokai.vim'
    Bundle 'scrooloose/nerdtree'
    Bundle 'vsushkov/nerdtree-ag'
    Bundle 'bkad/CamelCaseMotion'
    Bundle 'kien/ctrlp.vim'
    Bundle 'mattn/gist-vim'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'godlygeek/tabular'
    Bundle 'tomtom/tlib_vim'
    Bundle 'tpope/vim-abolish'
    Bundle 'MarcWeber/vim-addon-mw-utils'
    Bundle 'tpope/vim-git'
    Bundle 'tpope/vim-repeat'
    Bundle 'tpope/vim-surround'
    Bundle 'epmatsw/ag.vim'
    Bundle 'mattn/zencoding-vim'
    Bundle 'tpope/vim-fugitive'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'vim-scripts/vimwiki'
" Ultisnips
    Bundle 'SirVer/ultisnips'
    Bundle 'aalvarado/ultisnips-snippets'
    Bundle 'vsushkov/my-ultisnips-snippets'
" Coffescript / Javascript
    Bundle 'pangloss/vim-javascript'
    Bundle 'kchmck/vim-coffee-script'
    Bundle 'itspriddle/vim-jquery'
" JSON
    Bundle 'leshill/vim-json'
" Ruby / Rails
    Bundle 'tpope/vim-endwise'
    Bundle 'tpope/vim-rails'
" Markups
    Bundle 'tpope/vim-haml'
    Bundle 'tpope/vim-markdown'
" PHP
    Bundle 'vsushkov/vim-phpdocumentor'
" SASS/SCSS
    Bundle 'aaronjensen/vim-sass-status'
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
" }}}
" Settings {{{
syntax on
filetype plugin indent on
set hlsearch
set laststatus=2    " Always show the statusline
set encoding=utf-8  " Necessary to show unicode glyphs
set tabstop=4       " numbers of spaces of tab character
set softtabstop=4
set shiftwidth=4    " numbers of spaces to (auto)indent
set scrolloff=3     " keep 3 lines when scrolling
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set noerrorbells
set visualbell t_vb=    " turn off error beep/flash
set nonumber        " do not show line numbers
set ignorecase      " ignore case when searching
set smartindent
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

" Don't update the display while executing macros
set lazyredraw

" Don't show the current command in the lower right corner. In OSX, if this is
" set and lazyredraw is set then it's slow as molasses, so we unset this
set noshowcmd

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
set timeoutlen=500

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Make the command-line completion better
set wildmenu

" Use persistent undo
if has('persistent_undo')
    set undodir=/tmp
    set undolevels=5000
    set undofile
endif
set noshowmatch
" }}}
" Autocommands {{{
autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
autocmd FileType php setlocal ai sw=4 sts=4 et tw=120
autocmd FileType sh :compiler sh
autocmd FileType gitcommit setlocal colorcolumn=50,72 tw=72
autocmd FileType md,markdown setlocal colorcolumn=72 tw=72
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
autocmd BufWritePost *.md,*.markdown :silent !cat %:p | curl -X PUT -T - http://localhost:8090/
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType ruby,markdown,yaml let b:noStripWhitespace=1
" apply .vimrc after save
autocmd BufWritePost .vimrc source %
autocmd bufwritepost .vimrc call Pl#Load()
" Save when losing focus
autocmd FocusLost * :wa
" Resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="
" }}}
" Mappings {{{
" Leader
let mapleader = ","
let maplocalleader = "\\"

" Beatify XML
nmap <Leader>x :%s/></>\r</g<CR>gg=G

" Copy filepath to sysbuffer
nmap <Leader>p :let @+=expand("%")<CR>

noremap <F2> :set list!<CR>
noremap <F3> :make<CR>
noremap <F7> :!xmllint --noout %<CR>

" Made D and Y behave more logical
nnoremap D d$
nnoremap Y y$

" Keep search matches in the middle of the window and pulse the line when moving to them.
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g; g;zz
nnoremap g, g,zz

" Delete current buffer
nmap <C-c> :bd<CR>

" Quick jumping between splits
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
noremap <leader>v <C-w>v

map <S-Enter> O<Esc>j
map <CR> o<Esc>

" edit .vimrc
nmap <silent> ;v :next $MYVIMRC<CR>

" tmp file
nmap tt :next /tmp/temprary_file<CR>

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Switch off manual and help keys.
map K <nop>
map <F1> <nop>
imap <F1> <nop>
vmap K <nop>
vmap <F1> <nop>

" substitution
nmap S :%s//g<LEFT><LEFT>

" Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
vmap <BS> x

" Make vaa select the entire file...
vmap aa VGo1G

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Don't use Ex mode; use Q for formatting
map Q gqj

nmap <Leader>c :e! ++enc=cp1251 ++ff=dos  <CR>
" }}}
" Plugins settings {{{
" Coffe
let coffee_compile_vert = 1

" Powerline settings
let g:Powerline_symbols = 'unicode'

" Tabularize
vmap <Leader>t :Tab /=><CR>
nmap <Leader>a vib:Tab /=><CR>
nmap <Leader>C viB:Tab /:/r0c1l0<CR>

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

" CtrP ignore
let g:ctrlp_max_files = 30000
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|var$\|downloader$\|errors$\|pkginfo$\|media$',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|.jpg$\|\.gif$\|\.png$\|\.alist$\|\.clist$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Easymotion settings
let g:EasyMotion_leader_key = '<Leader>'

" UltiSnips settings
let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsSnippetDirectories = ['UltiSnips', '']

" VimWiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]
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

    colorscheme solarized
    call togglebg#map("<F12>")

    "let g:molokai_original=1
    "colorscheme molokai
    "colorscheme rdark
    "colorscheme Tomorrow
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar

    " Easy text shift
    vnoremap ≤ <gv
    vnoremap ≥ >gv
    " no search highlight
    noremap ÷ :nohl<CR>
    " fugitive
    noremap © :Git<Space>

    if exists('+colorcolumn')
         set colorcolumn=120
    endif
endif
" }}}
