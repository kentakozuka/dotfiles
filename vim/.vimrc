" plugins
filetype off
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'tomasr/molokai'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-visualstar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

Plug 'editorconfig/editorconfig-vim'
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }

call plug#end()
filetype plugin indent on

"--------------------
" basic settings
syntax enable
set number
set autoindent
set autoread
set noswapfile
set backspace=indent,eol,start
set hlsearch
set incsearch
set ignorecase
set splitright
set splitbelow
set clipboard=unnamed
set laststatus=2

" encodings
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" trailing space
set list
set listchars=tab:»\ ,trail:-

" output grep results to quickfix window
au QuickFixCmdPost *grep* cwindow

" disable completion preview window
set completeopt=menuone

" disable auto comment out
au FileType * setlocal formatoptions-=ro

" indent
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
au BufNewFile,BufRead *.py,*.java set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
au BufNewFile,BufRead *.go,*.mk,Makefile set tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" colorscheme
set background=dark
let g:molokai_original = 1
let g:rehash256 = 1
color molokai

"--------------------
" key mappings
nnoremap <Leader>\ :nohl<CR>
nnoremap <C-w>x <C-w>s
inoremap <C-o> <C-x><C-o>

" move
inoremap <C-f> <Right>
inoremap <C-b> <Left>
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" delete
inoremap <C-h> <BS>
inoremap <C-d> <Del>

" command
command! W w
command! Q q

"--------------------
" plugin settings
" fzf
nnoremap <silent><C-p> :Files<CR>
nnoremap <silent><Leader>b :Buffers<CR>
nnoremap <silent><Leader>m :History<CR>
