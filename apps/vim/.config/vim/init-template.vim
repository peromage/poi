""
"" Created by peromage on 2020/06/04
""
"" init.vim template
"" Rename this file to "init.vim" or "vimrc" and make your own changes in it
""

" Override these variables to control RC behaviors
"
"let g:RC_Color = "dracula"
"let g:RC_Plugs_Custom = ["coc", "leaderf"]
"let g:RC_Plugs = [
"            \ "Plug 'sheerun/vim-polyglot'"
"            \ ]
"let g:RC_Coc_Extensions = [
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
"            \ "coc-python"
"            \ ]

" Set runtime paths for plugins
"
"set runtimepath+=/home/linuxbrew/.linuxbrew/opt/fzf
"let g:python3_host_prog="/usr/bin/python3"
"let g:python_host_prog="/usr/bin/python2"

" Shortcut to open initial file
let s:init_file = expand("<sfile>:p")
command! RCConfig execute "edit ".s:init_file
" Load rc file
execute "source ".resolve(expand("<sfile>:h"))."/"."vimrc.vim"
