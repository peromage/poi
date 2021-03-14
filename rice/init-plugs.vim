""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Bundle settings (vim-plug)
"
" Created by peromage 2021/02/24
" Last modified 2021/02/24
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" Check enabled bundle group
"-------------------------------------------------------------------------------
let s:rt = {}
let s:enabled = {}

if !rice#get_var('rice_plug_group', s:rt)
    let g:rice_plug_group = []
endif

for key in g:rice_plug_group
    let s:enabled[key] = 1
endfor

function! s:check_enabled(group) abort
    return has_key(s:enabled, a:group)
endfunction

"-------------------------------------------------------------------------------
" Group: basic
"-------------------------------------------------------------------------------
if s:check_enabled('basic')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    IncRicePlug coc.vim

    Plug 'Yggdroot/LeaderF', { 'do': './install.sh'}
    IncRicePlug leaderf.vim

    Plug 'mhinz/vim-startify'
    IncRicePlug startify.vim

    Plug 'itchyny/lightline.vim'
    IncRicePlug lightline.vim
endif

"-------------------------------------------------------------------------------
" Group: git
"-------------------------------------------------------------------------------
if s:check_enabled('git')
    Plug 'tpope/vim-fugitive'
    IncRicePlug fugitive.vim
endif

"-------------------------------------------------------------------------------
" Group: terminal
"-------------------------------------------------------------------------------
if s:check_enabled('terminal')
    Plug 'voldikss/vim-floaterm'
    IncRicePlug floaterm.vim
endif

"-------------------------------------------------------------------------------
" Group: syntax
"-------------------------------------------------------------------------------
if s:check_enabled('syntax')
    Plug 'sheerun/vim-polyglot'
    IncRicePlug polyglot.vim
endif
