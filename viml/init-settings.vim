""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Common settings
"
" Created by peromage 2021/02/23
" Last modified 2021/03/18
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" Quality of life
"-------------------------------------------------------------------------------
set nocompatible

"-------------------------------------------------------------------------------
" Windows
"-------------------------------------------------------------------------------
set splitbelow
set splitright
set winaltkeys=no
set nolazyredraw

"-------------------------------------------------------------------------------
" Visual and experience
"-------------------------------------------------------------------------------
" Experience adjustment
set wildmenu
set ruler
set nowrap
" Headsup of line length
set colorcolumn=80,120
" Line numbers
set number
set relativenumber
set signcolumn=yes
" Colors
set background=dark
set notermguicolors
" Cursor
set cursorline
set scrolloff=0
set backspace=indent,eol,start
" Remove warning when switch buffer that is not saved
set hidden
" Show control characters
set list
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:%
" Misc
set conceallevel=0
set showtabline=1
set showmode
set clipboard=

"-------------------------------------------------------------------------------
" Syntax
"-------------------------------------------------------------------------------
filetype plugin indent on
syntax on

"-------------------------------------------------------------------------------
" Searching
"-------------------------------------------------------------------------------
set hlsearch
set incsearch
set ignorecase
set smartcase
set tagcase=followscs
set magic

"-------------------------------------------------------------------------------
" Indentation
"-------------------------------------------------------------------------------
" Unify tab width
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Folding
set nofoldenable
set foldmethod=indent
set foldlevel=99
set foldnestmax=20
" Auto indent
set autoindent
set smartindent
set cindent

"-------------------------------------------------------------------------------
" Format and encoding
"-------------------------------------------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set termencoding=utf-8
set fileformats=unix,dos,mac

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
" Fix EOL
set endofline
set fixendofline

"-------------------------------------------------------------------------------
" Tags
"-------------------------------------------------------------------------------
set tags+=./.tags;
set tags+=.tags

"-------------------------------------------------------------------------------
" Interactive
"-------------------------------------------------------------------------------
set mouse=a

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
