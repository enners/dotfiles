set nocompatible
set backspace=indent,eol,start
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
"  set hlsearch
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4

" plugin system pahtogen
execute pathogen#infect()

" go language support
let g:go_gmt_command = "goimports"
set backupdir=/tmp
set autoindent
filetype plugin indent on
syntax on

