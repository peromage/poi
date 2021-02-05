" Rice GUI init template file.
" Modified by peromage on 2021/02/04

" Initialization
"-------------------------------------------------------------------------------
" Shortcut to open this file
let g:gui_init_file = expand('<sfile>:p')
command! GuiInitFile execute 'edit '.g:gui_init_file
" Initialize rice
call rice#guiBegin()

" Space in the font name must be escaped
"let g:rice_gui_font = "Cascadia\ Code\ PL:h9"

" Currently supported: 'neovimqt', 'gvim'
"let g:rice_gui_frontend = ''

call rice#guiEnd()
"-------------------------------------------------------------------------------
