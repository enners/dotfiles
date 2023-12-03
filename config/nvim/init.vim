"
" first install packer.nvim
" git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
"

"
" general
let mapleader = "\<Space>"
set autowrite
set background=dark
set backupdir=/tmp
set clipboard+=unnamedplus "connect to sys clipboard
set completeopt=menuone,noinsert,noselect
set cursorline
set diffopt+=vertical
set mouse=a
set relativenumber
set number
set nowrap
set shiftwidth=2
set splitright
set tabstop=2
" search
set showmatch
set ignorecase
set smartcase
set path=$PWD/** "search path from current dir downwards
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

colorscheme lunaperche
highlight Normal ctermbg=NONE
highlight MatchParen cterm=bold

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

"
" plugins
lua require('plugins')

"
" key bindings
nmap     <leader>w :w<CR>
nnoremap <leader><leader> <c-^> " toggle between buffers
nnoremap <leader>,  <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>fd <cmd>Telescope lsp_document_symbols<CR> 
nnoremap <leader>fn <cmd>NeoTreeFocusToggle<CR> 

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
lua require("nvim-dap-virtual-text").setup()
lua require('mason').setup()

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
"lua require('dap-go').setup()

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
  "autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" debug
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
autocmd filetype go   nmap <silent> <leader>dt :lua require('dap-go').debug_test()<CR>
autocmd filetype java nmap <silent> <leader>dt :lua require'jdtls'.test_nearest_method()<CR>
autocmd filetype java nmap <silent> <leader>dtc :lua require'jdtls'.test_class()<CR>

" dadbod [UI] 
let g:db_ui_execute_on_save = 0
nnoremap <silent> <Leader>db :DBUIToggle<CR>
autocmd FileType sql xmap <expr> <C-M> db#op_exec()
autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })

"
" file type preferences
augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile /tmp/mutt*              setfiletype mail
  autocmd Filetype mail                              setlocal spell tw=72 colorcolumn=73
  autocmd Filetype mail                              setlocal fo+=w
  autocmd Filetype mail nnoremap <leader>rv :call fzf#run({'options': '--reverse --prompt "Vorlagen"', 'down': 20, 'dir': '~/Vorlagen/', 'sink': 'r' })<CR>
  " Git commit message
  autocmd Filetype gitcommit                         setlocal spell tw=72 colorcolumn=73
  " Coded Text
  autocmd Filetype markdown                          setlocal spell tw=80 et ts=2
  autocmd FileType java                              setlocal tw=100 et ts=2 sw=2
  autocmd BufRead *.ts.tsx                           set filetype=typescript
  autocmd Filetype typescript                        setlocal tw=100 et ts=2 
augroup END

