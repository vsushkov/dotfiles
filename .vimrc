"
" My .vimrc
"
" Plug {{{
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'junegunn/vim-easy-align'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'vsushkov/my-snipmate-snippets'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'dyng/ctrlsf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'chriskempson/base16-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'elixir-editors/vim-elixir'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'bogado/file-line'
Plug 'mattn/emmet-vim'

call plug#end()
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

map Y y$

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" }}}
" Plugins settings {{{
vnoremap <silent> <Enter> :EasyAlign<cr>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" NERDTree
let g:NERDTreeCaseSensitiveSort = 1
let g:NERDTreeChDirMode = 2
map <Leader>4 :NERDTreeToggle <cr>
map <Leader>r :NERDTreeFind <cr>

" Fugitive
map <leader>gs :Gstatus<cr>
map <leader>gw :Gwrite<cr>
map <leader>gd :Gdiff<cr>
map <leader>gc :Gcommit<cr>
map <leader>gb :Gblame<cr>

" CtrlP
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|var$\|downloader$\|errors$\|pkginfo$\|\node_modules$\|media$',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|.jpg$\|\.gif$\|\.png$\|\.alist$\|\.clist$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" VimWiki
let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'ext': '.wiki'}]
let g:vimwiki_ext2syntax = {'.wiki': 'media'}

" }}}
" Functions {{{
fun! StripTrailingWhitespace()
    if exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun

fun! s:base16_customize() abort
  call Base16hi("Normal",        g:base16_gui05, "f7f9fc", g:base16_cterm05, g:base16_cterm00, "", "")
  call Base16hi("elixirModuleDeclaration", g:base16_gui0C, "", g:base16_cterm0C, "", "", "")
  call Base16hi("elixirAlias", g:base16_gui09, "", g:base16_cterm09, "", "", "")
  call Base16hi("elixirInclude", g:base16_gui0E, "", g:base16_cterm0E, "", "", "")
endfun
" }}}
" Settings {{{
set hlsearch
set noerrorbells
set visualbell t_vb=
set ignorecase
set smartcase
set autoread
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set shell=/usr/local/bin/zsh\ -l
set scrolloff=3
set nowrap
set noswapfile
set foldmethod=marker

if has('persistent_undo')
  set undodir=/tmp
  set undolevels=5000
  set undofile
endif
if has('mac')
  set macmeta
endif
" }}}
" Autocommands {{{
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType markdown,yaml let b:noStripWhitespace=1
" }}}
" GUI {{{
if has("gui_running")
    "let g:solarized_diffmode="high"

    "let g:airline#extensions#ale#enabled = 1

    "set lines=59
    "set columns=272
    "set background=light
    set guifont=Monaco:h13

    if (filereadable('mix.exs'))
        colorscheme base16-tomorrow
        "let g:airline_theme='tomorrow'
        " Customize Theme {{{

        augroup on_change_colorschema
          autocmd!
          autocmd ColorScheme * call s:base16_customize()
        augroup END

        "}}}
    else
        colorscheme solarized
        call togglebg#map("<F12>")
    endif

    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar

    " no search highlight
    noremap <M-/> :nohl<CR>

    if exists('+colorcolumn')
         set colorcolumn=+1
    endif
endif
" }}}
