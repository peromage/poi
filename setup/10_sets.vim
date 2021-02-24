"===============================================================================
"
" Common settings
"
" Created by peromage 2021/02/23
" Last modified 2021/02/23
"
"===============================================================================

"-------------------------------------------------------------------------------
" Quality of life
"-------------------------------------------------------------------------------
set nocompatible
set wildmenu
filetype plugin indent on

"-------------------------------------------------------------------------------
" Windows
"-------------------------------------------------------------------------------
set splitbelow
set splitright
set winaltkeys=no
set lazyredraw

"-------------------------------------------------------------------------------
" Status bar view
"-------------------------------------------------------------------------------
set laststatus=2
set statusline=
"Fold at begginning
set statusline+=\ %<
"File status
set statusline+=%-20.120f%<%([%M%R%W]%)
"Start folding from right aligned elements
set statusline+=%=%<
"Encoding info
set statusline+=\ [%Y,%{&fenc!=''?&fenc:&enc}%{(&bomb?\"(BOM)\":\"\")},%{&ff}]
"Navigation info
set statusline+=\ \(%l:%c,%P\)

"-------------------------------------------------------------------------------
" Appearance
"-------------------------------------------------------------------------------
set background=dark

"-------------------------------------------------------------------------------
" Line numbers
"-------------------------------------------------------------------------------
set number
set relativenumber
set signcolumn=yes

"-------------------------------------------------------------------------------
" Encoding
"-------------------------------------------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set termencoding=utf-8
set fileformats=unix,dos,mac

"-------------------------------------------------------------------------------
" Indentation
"-------------------------------------------------------------------------------
set backspace=indent,eol,start
set autoindent
set cindent

"-------------------------------------------------------------------------------
" Folding
"-------------------------------------------------------------------------------
set foldenable
set foldmethod=indent
set foldlevel=99

"-------------------------------------------------------------------------------
" Visual
"-------------------------------------------------------------------------------
set colorcolumn=80,120
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set ruler
set nowrap
set list
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:%

"-------------------------------------------------------------------------------
" Syntax
"-------------------------------------------------------------------------------
set syntax=on

"-------------------------------------------------------------------------------
" Searching
"-------------------------------------------------------------------------------
set hlsearch
set ignorecase
set smartcase
set incsearch

"-------------------------------------------------------------------------------
" Files
"-------------------------------------------------------------------------------
" Don't auto flush or read files
" Don't keep backup file unless it failed to write
set autoread
set noautowrite
set noautowriteall
set nobackup
set writebackup
set noundofile
set nobinary
set endofline
set fixendofline
" Remove warning when switch buffer that is not saved
set hidden

"-------------------------------------------------------------------------------
" Tags
"-------------------------------------------------------------------------------
set tags=./.tags;,.tags

"-------------------------------------------------------------------------------
" Enable mouse
"-------------------------------------------------------------------------------
set mouse=a
