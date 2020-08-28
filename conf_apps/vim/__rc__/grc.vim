"""""""""""""""""""""""""""""""""""""""
"" Created by peromage on 2020/08/03 ""
"""""""""""""""""""""""""""""""""""""""
""
"" RC core initialization file for GUI
""

" Configurations for neovim-qt
if has("nvim")
" Use "g:RC_Gui_Font" to set font and font styles
if exists("g:RC_Gui_Font")
    " Command to fix the display issue when moving window accross monitors
    " with difference DPIs
    command! ResetGuiFont execute "Guifont! ".GuiFont
    execute "Guifont! ".g:RC_Gui_Font
endif " GuiFont

" Vim GUI
else
endif " nvim

" Common
set guioptions=mrb
