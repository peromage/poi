""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rice GUI setup entry
"
" Created by peromage 2021/02/24
" Last modified 2021/02/24
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" This works with rice lib
"-------------------------------------------------------------------------------
if !exists('g:loaded_rice') && !g:loaded_rice | finish | endif
if !exists(':LoadSetup')
    command! -nargs=1 LoadSetup call rice#source_script("setup/<args>")
endif

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
    call rice#source_script('setup/frontends/' . s:rt.value . '.vim')
endif

"-------------------------------------------------------------------------------
" Load components
"-------------------------------------------------------------------------------
LoadSetup 50_gui_sets.vim
LoadSetup 51_gui_keymaps.vim

"-------------------------------------------------------------------------------
" Startup
"-------------------------------------------------------------------------------
" Always starts GUI in home directory
cd $HOME
