""" ginit.vim -- Poi GUI bootstrap

""------------------------------------------------------------------------------
"" Bootstrap
""------------------------------------------------------------------------------

PoiInclude gui-init-keymap
PoiInclude gui-init-config

""------------------------------------------------------------------------------
"" GUI configuration
""------------------------------------------------------------------------------

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

""------------------------------------------------------------------------------
"" The local config file for GUI
""------------------------------------------------------------------------------

call poi#source_if_exits(simplify(poi#home_dir . "/local-gui.vim"))
