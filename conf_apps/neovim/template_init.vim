" Rice NeoVim init template file.
" Modified by peromage on 2021/01/20

" Rename this file to init.vim or vimrc and make your own changes in it

"region Initialization
" Load rice core init file. If this file has been moved to other places change
" this path accordingly. Otherwise it should stay untouched.
execute 'source '.expand('<sfile>:h').'/__rc__/rc.vim'
" Shortcut to open this file
let g:INIT_FILE = expand('<sfile>:p')
command! RiceInitFile execute 'edit '.g:INIT_FILE
" Rice global configs
"let g:RICE_CONFIGS = {
"    \ 'color': 'dracula',
"    \ 'modules': ['spacevim-statusline'],
"    \ 'plugins': ['coc', 'leaderf'],
"    \ 'plug_install': [
"        \ 'Plug ''sheerun/vim-polyglot''',
"        \ 'Plug ''mhinz/vim-startify''',
"        \ 'Plug ''itchyny/lightline.vim'''
"        \ ]
"    \ }
call RiceConfigInit()
" Coc extensions.
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
" Runtime paths for plugins
"set runtimepath+=/home/linuxbrew/.linuxbrew/opt/fzf
"let g:python3_host_prog='python3'
"let g:python_host_prog='python2'
"endregion
