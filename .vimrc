syntax on

filetype plugin indent on

if has("gui_running")
    filetype off                    " force reloading *after* pathogen loaded
    call pathogen#infect()

    syntax on
    filetype plugin indent on

    " CtrP ignore
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\.hg$\|\.svn$\|var$\|downloader$\|errors$\|pkginfo$\|media$',
      \ 'file': '\.exe$\|\.so$\|\.dll$\|.jpg$\|\.gif$\|\.png$\|\.alist$\|\.clist$',
      \ 'link': 'some_bad_symbolic_links',
      \ }

    let g:ctrlp_max_files = 30000
    let g:solarized_diffmode="high"

    set lines=59
    set columns=271
    set background=light
    set guifont=Monaco:h12

    set hlsearch

    colorscheme solarized
    call togglebg#map("<F12>")

    "let g:molokai_original=1
    "colorscheme molokai

    "colorscheme rdark

    "colorscheme Tomorrow

    " Highlight VCS conflict markers
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    set nocompatible    " Disable vi-compatibility
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

    set shell=/usr/local/bin/zsh\ -l

    if exists('+colorcolumn')
         set colorcolumn=120
    endif

    " Use persistent undo
    if has('persistent_undo')
        set undodir=$HOME/tmp/.VIM_UNDO_FILES
        set undolevels=5000
        set undofile
    endif

    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar

    " Command line height
    set ch=1

    " don't create swap files
    set nobackup
    set nowritebackup
    set noswapfile
    set backupdir=~/tmp

    " Persistent undo
    if version >= 7300
        set undofile
        set undodir=/tmp
    endif

    " Leader
    let mapleader = ","
    let maplocalleader = "\\"

    " Delete current buffer
    nmap <C-c> :bd<CR>

    " Copy filepath to sysbuffer
    nmap <Leader>p :let @+=expand("%")<CR>

    " Tabularize
    vmap <Leader>t :Tab /=><CR>
    nmap <Leader>a vib:Tab /=><CR>
    nmap <Leader>C viB:Tab /:/r0c1l0<CR>

    " Beatify XML
    nmap <Leader>x :%s/></>\r</g<CR>gg=G

    noremap <F2> :set list!<CR>
    noremap <F3> :make<CR>
    noremap <F8> :!/usr/bin/php -l %<CR>
    noremap <F6> :Phpcs<CR>
    noremap <F7> :!xmllint --noout %<CR>

    " Coffe
    let coffee_compile_vert = 1
    au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

    " ACK settings
    let g:ackprg="ack -i -H --nocolor --nogroup --column --all"
    let g:ackhighlight="1"
    let g:path_to_search_app="ack -i --column --all"

    " Powerline settings
    let g:Powerline_symbols = 'unicode'

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

    " NERDTree-ACK
    let g:path_to_search_app = "ack-grep"

    " PHP Documentor settings
    let g:pdv_cfg_php4always = 0
    nmap <Leader>d :call PhpDocSingle()<CR>

    " vim redmine
    let g:redmine_auth_site = 'http://redmine.oggettoweb.com'
    let g:redmine_auth_key = '9f59eb4da0eb7223c6ac31e834087e94f095f19f'
    let g:redmine_author_id  = '30'
    let g:redmine_project_id  = 'fashionesta'
    let g:redmine_browser = 'open -a Google\ Chrome'

    " Easymotion settings
    let g:EasyMotion_leader_key = '<Leader>'

    " vim-phpunit
    hi def link PhpUnitFail ErrorMsg
    hi def link PhpUnitOK DiffAdd
    hi def link PhpUnitAssertFail WarningMsg
    let g:phpunit_highlights = 1
    let g:phpunit_params = '--stop-on-failure UnitTests.php'

    " Set the status line the way i like it
    set stl=%f\ %m\ %r%{fugitive#statusline()}\%=\ Line:%l/%L\ [%p%%]\ Col:%v

    " Don't update the display while executing macros
    set lazyredraw

    " Don't show the current command int he lower right corner.  In OSX, if this is
    " set and lazyredraw is set then it's slow as molasses, so we unset this
    set showcmd

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

    " Fix lines join
    " nmap J Jx

    " Quick jumping between splits
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-H> <C-W>h
    map <C-L> <C-W>l
    noremap <leader>v <C-w>v

    " Heresy
    inoremap <c-a> <esc>I
    inoremap <c-e> <esc>A

    " Space to toggle folds.
    nnoremap <Space> za
    vnoremap <Space> za

    " Switch off manual and help keys.
    map K <nop>
    map <F1> <nop>
    imap <F1> <nop>
    vmap K <nop>
    vmap <F1> <nop>

    " Easy text shift
    vnoremap ≤ <gv
    vnoremap ≥ >gv
    " no search highlight
    noremap ÷ :nohl<CR>
    " fugitive
    noremap © :Git<Space>

    map <S-Enter> O<Esc>j
    map <CR> o<Esc>

    " Made D and Y behave more logical
    nnoremap D d$
    nnoremap Y y$

    " Keep search matches in the middle of the window and pulse the line when moving
    " to them.
    nnoremap n nzzzv
    nnoremap N Nzzzv
    nnoremap * *zzzv
    nnoremap # #zzzv

    " Same when jumping around
    nnoremap g; g;zz
    nnoremap g, g,zz

    " edit .vimrc
    nmap <silent> ;v :next $MYVIMRC<CR>

    " tmp file
    nmap tt :next /tmp/temprary_file<CR>

    " substitution
    nmap S :%s//g<LEFT><LEFT>

    " Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
    vmap <BS> x

    " Make vaa select the entire file...
    vmap aa VGo1G

    " Sudo to write
    cmap w!! w !sudo tee % >/dev/null

    "autocmd FileType yaml,eruby,ruby setlocal shiftwidth=2 tabstop=2
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
    autocmd FileType php :compiler phpmd
    autocmd FileType php set ai sw=4 sts=4 et tw=120
    autocmd FileType sh :compiler sh
    autocmd FileType gitcommit setlocal colorcolumn=50,72 tw=72
    autocmd FileType md,markdown setlocal colorcolumn=72 tw=72

    autocmd BufWritePost *.md,*.markdown :silent !cat %:p | curl -X PUT -T - http://localhost:8090/

    " Save when losing focus
    autocmd FocusLost * :wa

    " Resize splits when the window is resized
    autocmd VimResized * exe "normal! \<c-w>="

    " Don't use Ex mode; use Q for formatting
    map Q gqj

    " remove trailing spaces before save
    fun! StripTrailingWhitespace()
        " Only strip if the b:noStripeWhitespace variable isn't set
        if exists('b:noStripWhitespace')
            return
        endif
        %s/\s\+$//e
    endfun

    autocmd BufWritePre * call StripTrailingWhitespace()
    autocmd FileType ruby,markdown let b:noStripWhitespace=1


    " apply .vimrc after save
    autocmd BufWritePost .vimrc source %

    " Make sure Vim returns to the same line when you reopen a file.
    " Thanks, Amit
    augroup line_return
        au!
        au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     execute 'normal! g`"zvzz' |
            \ endif
    augroup END

    let g:Powerline_symbols = 'unicode'

    nmap <Leader>c :e! ++enc=cp1251 ++ff=dos  <CR>
endif
