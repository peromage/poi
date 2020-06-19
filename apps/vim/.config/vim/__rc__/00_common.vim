""
"" Created by peromage on 2020/06/04
""
"" Command settings
""

" Quality of life
set nocompatible
filetype plugin indent on
set splitbelow
set splitright
set winaltkeys=no
set lazyredraw

" Status bar view
set laststatus=2
set statusline=
"Fold at begginning
set statusline+=%<
"File status
set statusline+=%-10.32f%<%([%M%R%W]%)
"Start folding from right aligned elements
set statusline+=%=%<
"Encoding info
set statusline+=\ [%Y,%{&fenc!=''?&fenc:&enc}%{(&bomb?\"(BOM)\":\"\")},%{&ff}]
"Navigation info
set statusline+=\ \(%l:%c,%P\)

" Appearance
set background=dark

" Line numbers
set number
set relativenumber
set signcolumn=yes

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set termencoding=utf-8
set fileformats=unix,dos,mac

" Mouse support
set mouse=a

" Remove warning when switch buffer that is not saved
set hidden

" Indentation
set backspace=indent,eol,start
set autoindent
set cindent

" Folding
set foldenable
set foldmethod=indent
set foldlevel=99

" Formatting
set colorcolumn=80,120
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set syntax=on
set ruler
set nowrap
set list
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:%
set endofline
set fixendofline
set nobinary

" Searching
set hlsearch
set ignorecase
set smartcase
set incsearch


" Don't auto flush or read files
" Don't keep backup file unless it failed to write
set autoread
set noautowrite
set noautowriteall
set nobackup
set writebackup
set noundofile

" Tags
set tags=./.tags;,.tags
