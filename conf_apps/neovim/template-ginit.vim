" Rice NeoVim GUI init template file.
" Modified by peromage on 2021/01/23

"region Initialization
" Shortcut to open this file
let g:gui_init_file = expand('<sfile>:p')
command! GuiInitFile execute 'edit '.g:gui_init_file
" Initialize rice
call rice#guiBegin()
"let g:rice_gui_font = 'Cascadia Code PL:h10'
call rice#guiEnd()
"endregion
