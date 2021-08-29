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
call poi#init_var('poi_plug_group', [])

let s:selected_groups = {}
for key in g:poi_plug_group
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
    PoiInc plug-lightline

    Plug 'mhinz/vim-startify'
    PoiInc plug-startify
endif

"-------------------------------------------------------------------------------
" Group: navigation
"-------------------------------------------------------------------------------
if s:select('navigation')
    Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
    PoiInc plug-leaderf
endif

"-------------------------------------------------------------------------------
" Group: coc
"-------------------------------------------------------------------------------
if s:select('coc')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    PoiInc plug-coc
endif

"-------------------------------------------------------------------------------
" Group: git
"-------------------------------------------------------------------------------
if s:select('git')
    Plug 'tpope/vim-fugitive'
    PoiInc plug-fugitive
endif

"-------------------------------------------------------------------------------
" Group: terminal
"-------------------------------------------------------------------------------
if s:select('terminal')
    Plug 'voldikss/vim-floaterm'
    PoiInc plug-floaterm
endif

"-------------------------------------------------------------------------------
" Group: syntax
"-------------------------------------------------------------------------------
if s:select('syntax')
    Plug 'sheerun/vim-polyglot'
    PoiInc plug-polyglot
endif
