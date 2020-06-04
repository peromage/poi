""
"" Created by peromage on 2020/06/04
""
"" init.vim template
"" Rename this file to "init.vim" or "vimrc" and make your own changes in it
""

execute "so".resolve(expand("<sfile>:h"))."/"."vimrc.vim"

" Override these variables to control RC behaviors
"let g:RC_Global_Plugs = ["coc"]
"let g:RC_Local_Plugs = ["Plug 'neoclide/coc.nvim', {'branch': 'release'}"]
"let g:RC_Color = "default"
"let g:RC_Coc_Extensions = ["coc-explorer"]

" Quick open initial file
let s:init_file = expand("<sfile>:p")
command! RcConfig execute "edit ".s:init_file

" Set some runtime paths for plugins
"set runtimepath+=/home/linuxbrew/.linuxbrew/opt/fzf
let g:python3_host_prog="/usr/bin/python3"
let g:python_host_prog="/usr/bin/python2"

call RCInit()
