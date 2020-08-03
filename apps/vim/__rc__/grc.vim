"""""""""""""""""""""""""""""""""""""""
"" Created by peromage on 2020/08/03 ""
"""""""""""""""""""""""""""""""""""""""
""
"" RC core initialization file for GUI
""

" Configure GUI options for NeoVim
if has("nvim")

" Use "g:RC_Gui_Font" to set font and font styles
if exists("g:RC_Gui_Font")
    execute "Guifont! ".g:RC_Gui_Font
endif

" Misc
set guioptions=mrb

endif

