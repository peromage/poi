" Status bar view
set laststatus=2
set statusline=
set statusline+=\ [%n%M%R%W]                                                    "Basic status
set statusline+=\ %F                                                            "Full path
set statusline+=%=%<                                                            "Start folding from right aligned elements
set statusline+=%{v:register}                                                   "Display active register
set statusline+=\ [%Y,%{&fenc!=''?&fenc:&enc}%{(&bomb?\"(BOM)\":\"\")},%{&ff}]  "Encoding info
set statusline+=\ (R%l/%L,C%c,%P)                                               "Navigation info
" Theme
set background=dark

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set termencoding=utf-8
set fileformats=unix,dos,mac

" Quality of life
set nocompatible
filetype plugin indent on
set splitbelow
set splitright
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
" Formatting
set colorcolumn=80
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set syntax=on
set number relativenumber
set hlsearch
set ruler
set nowrap
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
set endofline
set fixendofline
set nobinary

" Don't auto flush or read files
set noautoread
set noautowrite
set noautowriteall
" Tags
set tags=./.tags;,.tags
