"
" general
let mapleader = "\<Space>"
set autowrite
set backupdir=/tmp "coc has problems with backupfiles
set clipboard+=unnamedplus "connect to sys clipboard
set completeopt=menuone,noinsert,noselect
set diffopt+=vertical
set mouse=a
set relativenumber
set number
set nowrap
set shiftwidth=4
set splitright
set tabstop=4
" search
set showmatch
set ignorecase
set smartcase
set path=$PWD/** "search path from current dir downwards
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

highlight lineNr ctermfg=darkgrey cterm=italic

"
"Plugins
lua require('plugins')

" general 
"
autocmd vimenter * colorscheme gruvbox
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
nmap <leader>, :Buffers<CR>
" toggle between buffers
nnoremap <leader><leader> <c-^>
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
nnoremap <leader>f :Rg 

lua require('_lualine')

" programming
lua require('language_server')
lua require('autocomple')

" test
let test#strategy="neovim"
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

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
"
" file type preferences
autocmd FileType markdown setlocal tw=80 et ts=2 sw=2
autocmd FileType text setlocal tw=80
