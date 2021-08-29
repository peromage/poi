""" ginit.vim -- Poi GUI bootstrap

""=============================================================================
"" Setup
""=============================================================================
let g:gui_init_file = expand('<sfile>:p')
let g:gui_init_local = resolve(poi#home . "/local-gui.vim")
command! OpenGuiInitFile execute 'edit '.g:gui_init_file

""=============================================================================
"" Bootstrap
""=============================================================================
PoiInclude gui-init-settings
PoiInclude gui-init-keybindings

""=============================================================================
"" GUI configuration
""=============================================================================
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

""=============================================================================
"" Post startup actions for GUI
""=============================================================================
cd $HOME

""=============================================================================
"" Local file
""=============================================================================
call poi#source_if_exits(gui_init_local)
