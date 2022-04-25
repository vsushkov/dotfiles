"
" My .vimrc
"
" Plug {{{
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'junegunn/vim-easy-align'
Plug 'MarcWeber/vim-addon-mw-utils' | Plug 'tomtom/tlib_vim' | Plug 'garbas/vim-snipmate' | Plug 'honza/vim-snippets' | Plug 'vsushkov/my-snipmate-snippets'
Plug 'scrooloose/nerdtree'
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
" Plug 'posva/vim-vue'
Plug 'scrooloose/syntastic'
Plug 'dense-analysis/ale'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'lumiliet/vim-twig'
Plug 'vsushkov/nerdtree-fzf'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'alvan/vim-closetag'
Plug 'vim-vdebug/vdebug'
Plug 'tomasiser/vim-code-dark'

call plug#end()
" }}}
" Mappings {{{
" Leader
let mapleader = ","
let maplocalleader = "\\"

" Beatify XML
nmap <Leader>x :%s/></>\r</g<CR>gg=G

" Beatify JSON
nmap <Leader>j :%!python -m json.tool<CR>

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

map ì 10<C-W>>
map è 10<C-W><
map ë 5<C-W>-
map ê 5<C-W>+

" edit .vimrc
nmap <silent> <leader>v :next $MYVIMRC<CR>

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

nmap <C-P> :Files<CR>
nmap <Leader>h :History<CR>

nmap <Leader>t :botright terminal<CR>

nmap <silent> <leader>j :ALENext<CR>
nmap <silent> <leader>k :ALEPrevious<CR>
" }}}
" Plugins settings {{{
vnoremap <silent> <Enter> :EasyAlign<cr>

" NERDTree
let g:NERDTreeCaseSensitiveSort = 1
let g:NERDTreeChDirMode = 2
map <Leader>4 :NERDTreeToggle <cr>
map <Leader>r :NERDTreeFind <cr>

" Fugitive
map <leader>gs :Git<cr>
map <leader>gw :Gwrite<cr>
map <leader>gd :Gdiff<cr>
map <leader>gc :Gcommit<cr>
map <leader>gb :Gblame<cr>
map <leader>gl :Git pull<cr>
map <leader>gp :Git push<cr>

" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" VimWiki
let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'ext': '.wiki'}]
let g:vimwiki_ext2syntax = {'.wiki': 'media'}

" Ale
let g:ale_php_phpcs_standard = 'Magento2'

" SnipMate
let g:snipMate = { 'snippet_version' : 1 }

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

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
set expandtab
set notitle
set termwinsize=12x0

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
autocmd FileType xml set tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType js,vue set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType eelixir let b:splitjoin_split_callbacks = ['sj#html#SplitTags', 'sj#html#SplitAttributes']
autocmd FileType eelixir let b:splitjoin_join_callbacks = ['sj#html#JoinTags', 'sj#html#JoinAttributes']

if (filereadable('composer.lock'))
    autocmd FileType js,less set tabstop=4 shiftwidth=4 softtabstop=4
endif

" }}}
" GUI {{{
if has("gui_running")
    "let g:solarized_diffmode="high"
    let ayucolor="mirage"

    "set lines=59
    "set columns=272
    "set background=light
    set guifont=Monaco:h13

    if (filereadable('mix.exs'))
        colorscheme base16-tomorrow
        " Customize Theme {{{

        augroup on_change_colorschema
          autocmd!
          autocmd ColorScheme * call s:base16_customize()
        augroup END

        "}}}
    else
        "colorscheme solarized
        colorscheme nord
        call togglebg#map("<F5>")
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
