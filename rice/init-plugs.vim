""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Bundle settings (vim-plug)
"
" Created by peromage 2021/02/24
" Last modified 2021/03/14
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" Check enabled bundle group
"-------------------------------------------------------------------------------
call rice#init_var('rice_plug_group', [])

let s:selected_groups = {}
for key in g:rice_plug_group
    let s:selected_groups[key] = 1
endfor

function! s:select(group) abort
    return has_key(s:selected_groups, a:group)
endfunction

"-------------------------------------------------------------------------------
" Group: basic
"-------------------------------------------------------------------------------
if s:select('basic')
    Plug 'itchyny/lightline.vim'
    IncRicePlug lightline.vim

    Plug 'mhinz/vim-startify'
    IncRicePlug startify.vim
endif

"-------------------------------------------------------------------------------
" Group: navigation
"-------------------------------------------------------------------------------
if s:select('navigation')
    Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
    IncRicePlug leaderf.vim
endif

"-------------------------------------------------------------------------------
" Group: coc
"-------------------------------------------------------------------------------
if s:select('coc')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    IncRicePlug coc.vim
endif

"-------------------------------------------------------------------------------
" Group: git
"-------------------------------------------------------------------------------
if s:select('git')
    Plug 'tpope/vim-fugitive'
    IncRicePlug fugitive.vim
endif

"-------------------------------------------------------------------------------
" Group: terminal
"-------------------------------------------------------------------------------
if s:select('terminal')
    Plug 'voldikss/vim-floaterm'
    IncRicePlug floaterm.vim
endif

"-------------------------------------------------------------------------------
" Group: syntax
"-------------------------------------------------------------------------------
if s:select('syntax')
    Plug 'sheerun/vim-polyglot'
    IncRicePlug polyglot.vim
endif
