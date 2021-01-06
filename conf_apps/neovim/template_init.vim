"""""""""""""""""""""""""""""""""""""""
"" Created by peromage on 2020/06/04 ""
"""""""""""""""""""""""""""""""""""""""
""
"" init.vim template
"" Rename this file to "init.vim" or "vimrc" and make your own changes in it
""

" Override these variables to control RC behaviors
"
" The default color scheme.
"let g:RC_Color = "dracula"

" The loaded pre-configured plugins.
"let g:RC_Plugins = ["coc", "leaderf"]

" The extra plugins that are loaded by vim-plug.
"let g:RC_Plugins_Extra = [
"            \ "Plug 'sheerun/vim-polyglot'",
"            \ "Plug 'mhinz/vim-startify'",
"            \ "Plug 'itchyny/lightline.vim'"
"            \ ]

" The modules that are loaded on startup. 
"let g:RC_Modules = ["spacevim-statusline"]

" Coc extensions.
"let g:coc_global_extensions = [
"            \ "coc-explorer",
"            \ "coc-tabnine",
"            \ "coc-snippets",
"            \ "coc-git",
"            \ "coc-json",
"            \ "coc-markdownlint",
"            \ "coc-vimlsp",
"            \ "coc-clangd",
"            \ "coc-powershell",
"            \ "coc-tsserver",
"            \ "coc-pyright"
"            \ ]

" Runtime paths for plugins
"
"set runtimepath+=/home/linuxbrew/.linuxbrew/opt/fzf
"let g:python3_host_prog="/usr/bin/python3"
"let g:python_host_prog="/usr/bin/python2"

" Uncomment this to enable force initialization
"let g:RC_INIT = 0

"#region Do Not Touch
" Shortcut to open this file
let s:INIT_FILE = expand("<sfile>:p")
command! RCInitFile execute "edit ".s:INIT_FILE
" Load rc.vim
execute "source ".expand("<sfile>:h")."/__rc__/rc.vim"
"#endregion
