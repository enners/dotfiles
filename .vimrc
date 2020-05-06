"
" general
let mapleader = "\<Space>"
syntax on
filetype plugin indent on
colorscheme default
set autoindent
set autowrite
set backspace=indent,eol,start
"set backupdir=/tmp "coc has problems with backupfiles
set diffopt+=vertical
set encoding=utf-8
set mouse=a
set number
set nowrap
set ruler		" show the cursor position all the time
set scrolloff=3
set showcmd		" display incomplete commands
set shiftwidth=4
set splitright
set tabstop=4
" search
set hlsearch
set incsearch
set showmatch
set ignorecase
set smartcase
" make coc work, see https://github.com/neoclide/coc.nvim
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

highlight lineNr ctermfg=darkgrey cterm=italic

"
"Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/vim/plugged')
" editor
Plug 'godlygeek/tabular'	" text alignment
Plug 'airblade/vim-rooter'	" workdir to git-root
Plug 'junegunn/fzf.vim'		" fuzzy search
" language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'rust-lang/rust.vim'
Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
call plug#end()

" general bindings
"
nmap <leader>, :Buffers<CR>
" toggle between buffers
nnoremap <leader><leader> <c-^>
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>
nnoremap <leader>f :Rg

" go
let g:go_gmt_command = "goimports"
let g:go_list_type = "quickfix"
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

"
" coc
"
" tab for trigger completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" <cr> to confirm completion, <C-g>u to abort 
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <S-F6>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" jump to next/previous error
nmap <silent> <F2>   <Plug>(coc-diagnostic-next-error)
nmap <silent> <S-F2> <Plug>(coc-diagnostic-prev-error)

"
"
" file type preferences
autocmd FileType markdown setlocal tw=80 et ts=2 sw=2
autocmd FileType text setlocal tw=80
