" Make Vim more useful
set nocompatible

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
        set undodir=~/.vim/undo
endif

" Enable line numbers
" set number
set nonumber

" Enable syntax highlighting
syntax on

" Make tabs as wide as two spaces
set tabstop=2

" Highlight searches
set hlsearch

" Disable error bells
set noerrorbells

" Show the cursor position
set ruler

" Show the filename in the window titlebar
set title

" Initialize pathogen
execute pathogen#infect()

" Settings for solorized
syntax enable
set background=dark
colorscheme solarized

