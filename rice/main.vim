""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rice setup entry
"
" Created by peromage 2021/02/23
" Last modified 2021/02/23
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" This works with rice lib
"-------------------------------------------------------------------------------
if !exists('g:loaded_rice') && !g:loaded_rice | finish | endif

"-------------------------------------------------------------------------------
" Load components
"-------------------------------------------------------------------------------
" Load configs first
IncRiceInit configs.vim
IncRiceInit sets.vim
IncRiceInit keymaps.vim
IncRiceInit commands.vim
IncRiceInit netrw.vim
IncRiceInit plugs.vim
