" Rice init template file.
" Modified by peromage on 2021/02/22

" Initialization (use :PlugInstall for the first time)
"-------------------------------------------------------------------------------
let g:init_file = expand('<sfile>:p')
let g:init_home = expand('<sfile>:h')
" Runtime path must be added
let &runtimepath = &runtimepath . ','. g:init_home
" Shortcut to open this file
command! InitFile execute 'edit '.g:init_file
" Initialize rice
call rice#begin()

" Color scheme. Leave this unset to use default color.
"let g:rice_color = 'dracula'

" Set Python runtime for Vim or NeoVim
"let g:rice_neovim_python_interpreter = 'python'
"let g:rice_neovim_python2_interpreter = 'python2'
"let g:rice_vim_python_home = 'python_home'
"let g:rice_vim_python_dll = 'python3x.dll'
"let g:rice_vim_python2_home = 'python2_home'
"let g:rice_vim_python2_dll = 'python27.dll'

" To disable built-in boosts, use name patterns to match (regex)
"let g:rice_disabled_boost = ['coc', 'leaderf']

" Extra Coc plugins
"let g:coc_global_extensions = [
"\   'coc-clangd',
"\   'coc-powershell',
"\   'coc-tsserver',
"\   'coc-pyright'
"\   ]

" Extra plugins via vim-plug
"Plug 'sheerun/vim-polyglot'

call rice#end()
"-------------------------------------------------------------------------------
