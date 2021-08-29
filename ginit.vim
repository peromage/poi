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
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gui_init_file = expand('<sfile>:p')
let g:gui_init_local = resolve(init_home . "/local-gui.vim")
command! OpenGuiInitFile execute 'edit '.g:gui_init_file

" Bootstrap
PoiInclude gui-init-settings
PoiInclude gui-init-keybindings

" GUI configuration
if has('nvim')
    if exists('g:GuiLoaded')
        PoiInclude gui-neovimqt
    elseif exists('g:fvim_loaded')
        PoiInclude gui-fvim
    else
        " Nothing
    endif
else
    if has('gui_running')
        PoiInclude gui-gvim
    else
        " Nothing
    endif
endif

" Always starts GUI in home directory
cd $HOME

" Local file
PoiSourceIfExists gui_init_local
