" Formatting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Appearance customization
set syntax=on
set number relativenumber
set hlsearch
set ruler
set nowrap
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
" Status bar view
set laststatus=2
set statusline=%<\ [%n%H%M%R%W]\ %-40f\ %=%y\ %10((R%l,C%c)%)\ %P
" Theme
set background=dark

" Encoding
set encoding=utf-8
set fileencoding=uft-8
set fileencodings=ucs-bom,uft-8,latin1
set termencoding=utf-8

" Quality of life
set nocompatible
filetype plugin indent on
" Remove files that are not needed
set nobackup
set noundofile
" Mouse support
set mouse=a
" Remove warning when switch buffer that is not saved
set hidden
" Indentation
set backspace=indent,eol,start
set autoindent
" Don't auto flush or read files
set noautoread
set noautowrite
set noautowriteall
