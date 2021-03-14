""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rie GUI initialization template
"
" Created by peromage 2021/02/24
" Last modified 2021/03/14
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
" Currently supported: 'neovimqt', 'gvim'
"----------------------------------------
"let g:rice_gui_frontend = has('nvim') ? 'neovimqt' : 'gvim'
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"### Rice config should start before this line ###
call rice#gui_init()
"### Other config should start after this line ###
