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
    PoiInclude plug-lightline

    Plug 'mhinz/vim-startify'
    PoiInclude plug-startify
endif

"-------------------------------------------------------------------------------
" Group: navigation
"-------------------------------------------------------------------------------
if s:select('navigation')
    Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
    PoiInclude plug-leaderf
endif

"-------------------------------------------------------------------------------
" Group: coc
"-------------------------------------------------------------------------------
if s:select('coc')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    PoiInclude plug-coc
endif

"-------------------------------------------------------------------------------
" Group: git
"-------------------------------------------------------------------------------
if s:select('git')
    Plug 'tpope/vim-fugitive'
    PoiInclude plug-fugitive
endif

"-------------------------------------------------------------------------------
" Group: terminal
"-------------------------------------------------------------------------------
if s:select('terminal')
    Plug 'voldikss/vim-floaterm'
    PoiInclude plug-floaterm
endif

"-------------------------------------------------------------------------------
" Group: syntax
"-------------------------------------------------------------------------------
if s:select('syntax')
    Plug 'sheerun/vim-polyglot'
    PoiInclude plug-polyglot
endif
