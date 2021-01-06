"""""""""""""""""""""""""""""""""""""""
"" Created by peromage on 2020/08/03 ""
"""""""""""""""""""""""""""""""""""""""
""
"" RC core initialization file for GUI
""

" Configurations for neovim-qt
if get(g:, "RC_Gui_Frontend", "null") == "nvim-qt"
    echo "nvim-qt detected!"
    " Command to fix the display issue when moving window accross monitors
    " with difference DPIs
    command! ResetGuiFont execute "Guifont! ".GuiFont
    " Set font
    if exists("g:RC_Gui_Font")
        execute "Guifont! ".g:RC_Gui_Font
    endif
    " Context menu
    nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
    inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
    vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
endif

" Gui common options
set guioptions=mrb
