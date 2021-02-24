"===============================================================================
"
" Rice GUI setup entry
"
" Created by peromage 2021/02/24
" Last modified 2021/02/24
"
"===============================================================================

"-------------------------------------------------------------------------------
" This works with rice lib
"-------------------------------------------------------------------------------
if !exists('g:loaded_rice') && !g:loaded_rice | finish | endif

"-------------------------------------------------------------------------------
" Read global config variables
"-------------------------------------------------------------------------------
let s:rt = {}

" Color
if rice#get_var('rice_gui_font', s:rt)
    let &guifont = s:rt.value
endif

" Frontend
if rice#get_var('rice_gui_frontend', s:rt)
    call rice#load_script('setup/frontends/' . s:rt.value . '.vim')
endif

"-------------------------------------------------------------------------------
" Some other configs
"-------------------------------------------------------------------------------
" Balanced looking
set guioptions=egmrLtT

" Always starts GUI in home directory
cd $HOME
