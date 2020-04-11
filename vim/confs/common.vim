" Formatting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Appearance customization
syntax enable
syntax on
set number relativenumber
set hlsearch
set ruler
set nowrap
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
" Status bar view
set statusline=%<\ [%n%H%M%R%W]\ %-40f\ %=%y\ %10((R%l,C%c)%)\ %P
" Netrw view
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=15

" Quality of life
set nobackup
set noundofile
set mouse=a
