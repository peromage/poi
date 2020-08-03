"""""""""""""""""""""""""""""""""""""""
"" Created by peromage on 2020/08/02 ""
"""""""""""""""""""""""""""""""""""""""
""
"" ginit.vim template
"" Rename this file to "ginit.vim" or "gvimrc" and make your own changes in it
""

"#region User Configurations

" Override these variables to control RC behaviors
"
"let g:RC_Gui_Font = "Cascadia Code PL:h10"

"#endregion


"===============================================================================


"#region Initialization Do Not Touch

" Configure GUI options for NeoVim
if has("nvim")

" Use "g:RC_Gui_Font" to set font and font styles
if exists("g:RC_Gui_Font")
    execute "Guifont! ".g:RC_Gui_Font
endif

" Misc
set guioptions=mrb

endif

"#endregion
