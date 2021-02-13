" Rice init template file.
" Modified by peromage on 2021/02/05

" Initialization
"-------------------------------------------------------------------------------
" Runtime path must be added
let &runtimepath = &runtimepath . ','. expand('<sfile>:h')
" Shortcut to open this file
let g:init_file = expand('<sfile>:p')
command! InitFile execute 'edit '.g:init_file
" Initialize rice
call rice#begin('~/.vimplugged')

" Python runtime
"let g:rice_neovim_python_interpreter = 'python'
"let g:rice_neovim_python2_interpreter = 'python2'
"let g:rice_vim_python_home = 'python_home'
"let g:rice_vim_python_dll = 'python3x.dll'
"let g:rice_vim_python2_home = 'python2_home'
"let g:rice_vim_python2_dll = 'python27.dll'

" Rice configs
"let g:rice_color = 'dracula'
"let g:rice_plugging = ['coc', 'leaderf', 'floaterm']

" Coc plugins
"let g:coc_global_extensions = [
"\   'coc-explorer',
"\   'coc-tabnine',
"\   'coc-snippets',
"\   'coc-git',
"\   'coc-json',
"\   'coc-markdownlint',
"\   'coc-vimlsp',
"\   'coc-clangd',
"\   'coc-powershell',
"\   'coc-tsserver',
"\   'coc-pyright'
"\   ]

" Extra plugins via vim-plug
"Plug 'sheerun/vim-polyglot'
"Plug 'mhinz/vim-startify'
"Plug 'itchyny/lightline.vim'
"Plug 'tpope/vim-fugitive'

call rice#end()
"-------------------------------------------------------------------------------
