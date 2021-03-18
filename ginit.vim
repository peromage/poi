""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rie GUI initialization template
"
" Created by peromage 2021/02/24
" Last modified 2021/03/18
"
"
" This section should remain untouched
" Initialization for GUI
let g:gui_init_file = expand('<sfile>:p')
command! GuiInitFile execute 'edit '.g:gui_init_file
"
" Examples of configuration options
"
" Space in the font name must be escaped
"---------------------------------------
"let g:rice_gui_font = "Cascadia\ Code\ PL:h9"
"
" Enable this option to automatically load supported GUI config
" NeoVim: neovim-qt, fvim
" Vim: gvim
"--------------------------------------------------------------
"let g:rice_gui_use_config = 1
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"### BEGIN: Rice config ###

"### END: Rice config ###
call rice#gui_init()
"### Your config should start after this line ###
