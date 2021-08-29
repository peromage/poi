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
    IncPoi vscode.vim
else
    " Load configs first
    IncPoiInit configs.vim
    IncPoiInit sets.vim
    IncPoiInit keymaps.vim
    IncPoiInit commands.vim
    IncPoiInit netrw.vim
    IncPoiInit plugs.vim
endif
