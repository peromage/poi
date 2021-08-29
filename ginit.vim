""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Poi GUI initialization
"
" Created by peromage 2021/02/24
" Last modified 2021/08/28
"
"
" This file should remain untouched
" Initialization for GUI
"
"
" Examples of configuration options (Put them in local-gui.vim)
"
" Space in the font name must be escaped
"---------------------------------------
"let g:poi_gui_font = "Cascadia\ Code\ PL:h9"
"
" Enable this option to automatically load supported GUI config
" NeoVim: neovim-qt, fvim
" Vim: gvim
"--------------------------------------------------------------
"let g:poi_gui_use_config = 1
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gui_init_file = expand('<sfile>:p')
let g:gui_init_local = resolve(init_home . "/local-gui.vim")
command! OpenGuiInitFile execute 'edit '.g:gui_init_file

" Bootstrap
PoiInclude gui-init-configvars
PoiInclude gui-init-settings
PoiInclude gui-init-keybindings

" Always starts GUI in home directory
cd $HOME

" Local file
if filereadable(gui_init_local)
    execute 'source ' . gui_init_local
endif

call poi#gui_init()
