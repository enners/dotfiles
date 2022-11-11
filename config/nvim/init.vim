"
" first install packer.nvim
" git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
"

"
" general
let mapleader = "\<Space>"
set autowrite
set backupdir=/tmp
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
nmap     <leader>w :w<CR>
nnoremap <leader><leader> <c-^> " toggle between buffers
nnoremap <leader>, :Buffers<CR>
nnoremap <leader>fs :Rg<CR> 
nnoremap <leader>ff :Files<CR> 

" search moves keep cursor centered
:nnoremap n nzz
:nnoremap N Nzz
:nnoremap * *zz
:nnoremap # #zz
:nnoremap g* g*zz
:nnoremap g# g#zz

" programming
lua require('language_server')
lua require('autocomple')
lua require('dapui').setup()

" test
let test#strategy="dispatch"
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>


" go
let g:go_gmt_command = "goimports"
let g:go_list_type = "quickfix"
lua require('dap-go').setup()
let g:test#gotest#options = '-v'
"autocmd FileType go nmap <leader>b  <Plug>(go-build)
"autocmd FileType go nmap <leader>r  <Plug>(go-run)
"autocmd FileType go nmap <leader>t  <Plug>(go-test)

" javascript
"let g:test#javascript#"jest#options = '--config ../../../config/jest/default.json'
"let g:test#javascript#jest#executable = 'yarn test'

" rust
let g:rust_fold = 1
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 0 

" markdown
let g:vim_markdown_folding_disabled = 1 

" prettier
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" debug:
nnoremap <silent> <Leader>dc <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F5>       <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dj <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F7>       <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>dk <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <F12>      <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F8>       <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <Leader>db <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>dd <Cmd>lua require'dap'.run_last()<CR>
nnoremap <silent> <Leader>dm <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>du <Cmd>lua require'dapui'.toggle()<CR>
autocmd filetype go nmap <silent> <leader>dt :lua require('dap-go').debug_test()<CR>


"
" file type preferences
"autocmd filetype go inoremap <buffer> . .<C-x><C-o>
autocmd FileType markdown setlocal tw=80 et ts=2 sw=autocmd FileType text setlocal tw=autocmd BufRead *.ts.tsx set filetype=typescript
autocmd Filetype typescript setlocal tw=100 et ts=2 sw=autocmd BufRead,BufNewFile /tmp/mutt* setfiletype mail
autocmd Filetype mail nnoremap <leader>rv :call fzf#run({'options': '--reverse --prompt "Vorlagen"', 'down': 20, 'dir': '~/Vorlagen/', 'sink': 'r' })<CR>

