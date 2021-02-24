"===============================================================================
"
" Rice initialization template
"
" Created by peromage 2021/02/24
" Last modified 2021/02/24
"
"===============================================================================

"-------------------------------------------------------------------------------
" Initialization (use :PlugInstall for the first time)
"-------------------------------------------------------------------------------
let g:init_file = expand('<sfile>:p')
let g:init_home = expand('<sfile>:p:h')
" Runtime path must be added
exec 'set rtp+='.g:init_home
" Shortcut to open this file
comm! InitFile exec 'edit '.g:init_file

" Initialize rice
call rice#begin()

" Color scheme. Leave this unset to use default color.
"let g:rice_color = 'dracula'

" To disable built-in boosts, use name patterns to match (regex)
"let g:rice_bundle_group = ['basic']
"
" Set Python runtime for Vim or NeoVim
"let g:rice_neovim_python_interpreter = 'python'
"let g:rice_neovim_python2_interpreter = 'python2'
"let g:rice_vim_python_home = 'python_home'
"let g:rice_vim_python_dll = 'python3x.dll'
"let g:rice_vim_python2_home = 'python2_home'
"let g:rice_vim_python2_dll = 'python27.dll'

" Extra Coc plugins
" To override default extensions define this variable after rice#end()
"let g:coc_global_extensions = [
"\   'coc-clangd',
"\   'coc-powershell',
"\   'coc-tsserver',
"\   'coc-pyright'
"\   ]

" Extra plugins via vim-plug
" To override default bundles define vim-plug after rice#end()
"Plug 'sheerun/vim-polyglot'

call rice#end()
"-------------------------------------------------------------------------------
