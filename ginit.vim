""" ginit.vim -- Poi GUI bootstrap

""=============================================================================
"" Setup
""=============================================================================

let g:gui_init_local = simplify(poi.home_dir . "/local-gui.vim")

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
        "" Nothing
    endif
else
    if has('gui_running')
        PoiInclude gui-gvim
    else
        "" Nothing
    endif
endif

""=============================================================================
"" Post startup actions for GUI
""=============================================================================

cd $HOME

""=============================================================================
"" The local config file for GUI
""=============================================================================

call poi#source_if_exits(gui_init_local)
