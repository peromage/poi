""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rice (Neo)Vim initialization
"
" Created by peromage 2021/02/24
" Last modified 2021/08/28
"
"
" This file should remain untouched
" General initialization (use :PlugInstall for the first time)
"
"
" Examples of configuration options (Put them in local.vim)
"
" Color scheme. Leave this unset to use default color.
"-----------------------------------------------------
"let g:rice_color = 'dracula'
"
" Check 'rice/init-plugs.vim' for more groups
"--------------------------------------------
"let g:rice_plug_group = ['basic', 'navigation', 'syntax', 'coc', 'git']
"
" Whether use config for VSCode integration
"------------------------------------------
"let g:rice_vscode_use_config = 1
"
" Set Python runtime for NeoVim and Vim
"-------------------------------------
" NeoVim
"let g:rice_python_interpreter = 'python3'
" Vim
"let g:rice_python_home = '/path/to/python_dir'
"let g:rice_python_dll = '/path/to/python.dll'
"
" Extra Coc plugins
" To override default extensions define this variable after rice#end()
"---------------------------------------------------------------------
"let g:coc_global_extensions = [
"\   'coc-clangd',
"\   'coc-powershell',
"\   'coc-tsserver',
"\   'coc-pyright'
"\   ]
"
" Extra plugins via vim-plug
" To override default bundles define vim-plug after rice#end()
"-------------------------------------------------------------
"Plug 'Kenta11/helloworld-vim'
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:init_home = expand('<sfile>:p:h')
let g:init_file = expand('<sfile>:p')
let g:init_local = resolve(init_home . "/local.vim")
command! OpenInitFile exec 'edit '.g:init_file
execute 'set rtp+='.g:init_home

" Bootstrap

call rice#begin()

if filereadable(init_local)
    execute 'source ' . init_local
endif

call rice#end()
