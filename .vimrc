"
" My .vimrc
"
" Vundle {{{
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'
" like nocompatiable
    Plugin 'tpope/vim-sensible'
" My Bundles here:
    "Plugin 'tpope/vim-obsession'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'scrooloose/nerdtree'
    Plugin 'vsushkov/nerdtree-ack'
    "Plugin 'bkad/CamelCaseMotion'
    Plugin 'ctrlpvim/ctrlp.vim'
    "Plugin 'tacahiroy/ctrlp-funky'
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
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'vimwiki/vimwiki'
    "Plugin 'gregsexton/MatchTag'
    "Plugin 'sjl/gundo.vim'
    "Plugin 'evanmiller/nginx-vim-syntax'
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'ntpeters/vim-better-whitespace'
    "Plugin 'c-brenn/phoenix.vim'
    Plugin 'tpope/vim-projectionist'
    "Plugin 'slashmili/alchemist.vim'
    Bundle 'bogado/file-line'
" SnipMate
    Plugin 'garbas/vim-snipmate'
    Plugin 'honza/vim-snippets'
    Plugin 'vsushkov/my-snipmate-snippets'
" Coffescript / Javascript
    Plugin 'kchmck/vim-coffee-script'
" Ruby / Rails
    "Plugin 'vim-ruby/vim-ruby'
    Plugin 'tpope/vim-endwise'
    "Plugin 'tpope/vim-rails'
" PHP
    Plugin 'vsushkov/vim-phpdocumentor'
    "Plugin 'StanAngeloff/php.vim'
    "Plugin 'vsushkov/vim-phpcs'
    "Plugin 'xsbeats/vim-blade'
    "Plugin 'us3r64/vim-phpqa'
" SASS/SCSS/CSS
    Plugin 'hail2u/vim-css3-syntax'
" Elixir
    Plugin 'elixir-editors/vim-elixir'
    Plugin 'slim-template/vim-slim'
    Plugin 'slashmili/alchemist.vim'
" Colorschemes
    Plugin 'jpo/vim-railscasts-theme'
    Plugin 'altercation/vim-colors-solarized'
    "Plugin 'vsushkov/vim-tomorrow-theme'
    Plugin 'chriskempson/base16-vim'
    Plugin 'sjl/badwolf'
    Plugin 'tomasr/molokai'
call vundle#end()
filetype plugin indent on
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
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Keep search matches in the middle of the window and pulse the line when moving to them.
nnoremap n nzzzv
nnoremap N NzzzV
nnoremap * *zzzV
nnoremap # #zzzV
nnoremap g; g;zz
nnoremap g, g,zz

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

" edit .vimrc
nmap <silent> ;v :next $MYVIMRC<CR>

" tmp file
nmap tt :next /tmp/temprary_file<CR>

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Switch off manual and help keys.
imap <F1> <nop>
vmap <F1> <nop>

" EMACS-like mappings:
imap <C-a> <C-c>A

nmap <Leader>c :e! ++enc=cp1251 ++ff=dos  <CR>

nmap <Leader>t :call RunAllTests()<CR>

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

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

function! ClearTerminal()
    call SendToTerminal("clear")
endfunction

function! SendToTerminal(args)
    execute ":silent !run_command '" . a:args . "'"
endfunction

function! RunTest()
    call ClearTerminal()
    if exists("s:current_test")
        call SendToTerminal("mix test " . s:current_test)
    endif
endfunction

function! RunAllTests()
    call ClearTerminal()
    call SendToTerminal("mix test")
endfunction

function! RunCurrentTest()
    let s:current_test = expand('%:p')
    call RunTest()
endfunction

function! RunCurrentLineInTest()
    let s:current_test = expand('%:p') . ":" . line('.')
    call RunTest()
endfunction


" }}}
" Plugins settings {{{

" Coffe
let coffee_compile_vert = 1

" NERDTree
let g:NERDChristmasTree = 1
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 30
let g:NERDTreeCaseSensitiveSort = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
map <Leader>4 :NERDTreeToggle <cr>
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

" PHP QA
let g:phpqa_messdetector_cmd = './vendor/bin/phpmd'
let g:phpqa_codesniffer_cmd = './vendor/bin/phpcs'
let g:phpqa_codesniffer_args = "--standard=Oggetto"
let g:phpqa_messdetector_autorun = 0
let g:phpqa_codesniffer_autorun = 0
let g:phpqa_codecoverage_autorun = 1
let g:phpqa_codesnifferfixer_autorun = 0

" CtrlP
let g:ctrlp_max_files = 30000
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|var$\|downloader$\|errors$\|pkginfo$\|\node_modules$\|media$',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|.jpg$\|\.gif$\|\.png$\|\.alist$\|\.clist$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_extensions = ['funky']

" Easymotion settings
let g:EasyMotion_leader_key = '<Leader>'

" VimWiki
let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'ext': '.wiki'}]
let g:vimwiki_ext2syntax = {'.wiki': 'media'}

" ultisnips settings
"let g:snipMate['snippet_dirs'] = ['~/.vim/bundle/vim-snippets', '/Users/vsushkov/.vim/bundle/my-snipmate-snippets']
"let g:snipMate.scope_aliases = {}
"let g:snipMate.scope_aliases['php'] = 'php'
"let g:snipMate.scope_aliases['phtml'] = 'php,html,javascript'
"let g:snipMate.scope_aliases['scss'] = 'scss,css'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" NERDCommenter for ruby
let g:NERDCustomDelimiters = {
    \ 'ruby': { 'left': '# ' }
\ }

" Gundo
nnoremap <F5> :GundoToggle<CR>
let g:gundo_right = 1

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
"set noexpandtab
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
set synmaxcol=400
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
autocmd FileType elixir setlocal colorcolumn=80 tw=80
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
    elseif (filereadable('mix.exs'))
        colorscheme base16-tomorrow
        let g:airline_theme='tomorrow'
        " Customize Theme {{{

        function! s:base16_customize() abort
          call Base16hi("Normal",        g:base16_gui05, "f7f9fc", g:base16_cterm05, g:base16_cterm00, "", "")
          call Base16hi("elixirModuleDeclaration", g:base16_gui0C, "", g:base16_cterm0C, "", "", "")
          call Base16hi("elixirAlias", g:base16_gui09, "", g:base16_cterm09, "", "", "")
          call Base16hi("elixirInclude", g:base16_gui0E, "", g:base16_cterm0E, "", "", "")
        endfunction

        augroup on_change_colorschema
          autocmd!
          autocmd ColorScheme * call s:base16_customize()
        augroup END

        "}}}
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
