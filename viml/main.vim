""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Poi setup entry
"
" Created by peromage 2021/02/23
" Last modified 2021/03/18
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" This works with poi lib
"-------------------------------------------------------------------------------
if !exists('g:loaded_poi') || !g:loaded_poi | finish | endif

"-------------------------------------------------------------------------------
" Load components
"-------------------------------------------------------------------------------
if exists('g:vscode')
    IncPoi vscode
else
    " Load configs first
    PoiInc init-configs
    PoiInc init-sets
    PoiInc init-keymaps
    PoiInc init-commands
    PoiInc init-netrw
    PoiInc init-plugs
endif
