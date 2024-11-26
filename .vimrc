" works fine w/ optional distro plugins; used on arch w/
" vim-{autopairs,ctrlp,fugitive,gitgutter,surround,tabular}

"
" general
let mapleader = "\<Space>"
syntax on
filetype plugin indent on
set autoindent " nvim default
set autowrite
set background=dark
set backspace=indent,eol,start "nvim default 
set backupdir=/tmp
set clipboard+=unnamedplus
set cmdheight=2
set diffopt+=iwhite,indent-heuristic,algorithm:histogram,vertical
set encoding=utf-8
set hidden
set mouse=a
set nobackup
set nocompatible
set nofoldenable
set nowrap
set nowritebackup
set number
set path=$PWD/**
set relativenumber
set ruler		" show the cursor position all the time
set scrolloff=3
set shortmess+=c
set signcolumn=yes
set showcmd	" display incomplete commands, nvim default
set shiftwidth=4
set splitright
set tabstop=4
set updatetime=300
set wildmode=list:longest
" search
set hlsearch "nvim default
set incsearch "nvim default
set showmatch
set ignorecase
set smartcase

colorscheme lunaperche
highlight MatchParen cterm=bold
highlight Normal ctermbg=NONE guibg=NONE
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

"
" key bindings
nmap     <leader>w :w<CR>
nnoremap <leader><leader> <c-^>" toggle between buffers
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" search moves keep cursor centered
:nnoremap n nzz
:nnoremap N Nzz
:nnoremap * *zz
:nnoremap # #zz
:nnoremap g* g*zz
:nnoremap g# g#zz

"
"
" file type preferences
augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile /tmp/mutt*				setfiletype mail
  autocmd Filetype mail								setlocal spell tw=72 colorcolumn=73
  autocmd Filetype mail								setlocal fo+=w
  autocmd Filetype mail nnoremap <leader>rv :call fzf#run({'options': '--reverse --prompt "Vorlagen"', 'down': 20, 'dir': '~/Vorlagen/', 'sink': 'r' })<CR>
  " Git commit message
  autocmd Filetype gitcommit						setlocal spell tw=72 colorcolumn=73
  " Coded Text
  autocmd Filetype markdown							setlocal spell tw=80 et ts=2
  autocmd FileType java								setlocal tw=100 et ts=2 et sw=2 et colorcolumn=100
  autocmd Filetype rust								setlocal tw=100 et colorcolumn=100
  autocmd BufRead *.ts.tsx							set filetype=typescript
  autocmd Filetype typescript						setlocal tw=100 et ts=2 
augroup END

"
" disable unused lang providers
let g:loaded_perl_provider=0
let g:loaded_ruby_provider=0
let g:loaded_node_provider=0
let g:loaded_python_provider=0
let g:loaded_python3_provider=0

