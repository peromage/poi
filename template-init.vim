""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rice initialization template
" Copy the content of this file to your .vimrc or init.vim to get started
"
" Created by peromage 2021/02/24
" Last modified 2021/02/25
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"===============================================================================
" Initialization (use :PlugInstall for the first time)
" NOTE: Redirect g:init_home to the path of rice repo if this file is not at
" the root of rice
let g:init_home = expand('<sfile>:p:h')
"-------------------------------------------------------------------------------
let g:init_file = expand('<sfile>:p')
comm! InitFile exec 'edit '.g:init_file
exec 'set rtp+='.g:init_home
call rice#begin()
"-------------------------------------------------------------------------------

" Color scheme. Leave this unset to use default color.
"-----------------------------------------------------
"let g:rice_color = 'dracula'

" To disable built-in boosts, use name patterns to match (regex)
" Check 'setup/14_bundle.vim' for more groups
"--------------------------------------------
"let g:rice_bundle_group = ['basic', 'syntax']
"
" Set Python runtime for Vim or NeoVim
"-------------------------------------
"let g:rice_neovim_python_interpreter = 'python'
"let g:rice_neovim_python2_interpreter = 'python2'
"let g:rice_vim_python_home = 'python_home'
"let g:rice_vim_python_dll = 'python3x.dll'
"let g:rice_vim_python2_home = 'python2_home'
"let g:rice_vim_python2_dll = 'python27.dll'

" Extra Coc plugins
" To override default extensions define this variable after rice#end()
"---------------------------------------------------------------------
"let g:coc_global_extensions = [
"\   'coc-clangd',
"\   'coc-powershell',
"\   'coc-tsserver',
"\   'coc-pyright'
"\   ]

" Extra plugins via vim-plug
" To override default bundles define vim-plug after rice#end()
"-------------------------------------------------------------
"Plug 'Kenta11/helloworld-vim'

"-------------------------------------------------------------------------------
call rice#end()
"===============================================================================
