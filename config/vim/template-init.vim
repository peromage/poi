" Rice init template file.
" Modified by peromage on 2021/02/04

" Initialization
"-------------------------------------------------------------------------------
" Runtime path must be added
set runtimepath+=expand('<sfile>:h')
" Shortcut to open this file
let g:init_file = expand('<sfile>:p')
command! InitFile execute 'edit '.g:init_file
" Initialize rice
call rice#begin()

" Python for NeoVim
"let g:python3_host_prog = 'python3'
"let g:python_host_prog = 'python2'

" Python for Vim
"let &pythonthreehome = 'Python39'
"let &pythonthreedll = 'python39.dll'
"let &pythonhome = 'Python27'
"let &pythondll = 'python27.dll'

" Rice configs
"let g:rice_color = 'dracula'
"let g:rice_plugging = ['coc', 'leaderf', 'floaterm']

" Coc plugins
"let g:coc_global_extensions = [
"    \ 'coc-explorer',
"    \ 'coc-tabnine',
"    \ 'coc-snippets',
"    \ 'coc-git',
"    \ 'coc-json',
"    \ 'coc-markdownlint',
"    \ 'coc-vimlsp',
"    \ 'coc-clangd',
"    \ 'coc-powershell',
"    \ 'coc-tsserver',
"    \ 'coc-pyright'
"    \ ]

" Extra plugins via vim-plug
"Plug 'sheerun/vim-polyglot'
"Plug 'mhinz/vim-startify'
"Plug 'itchyny/lightline.vim'

call rice#end()
"-------------------------------------------------------------------------------
