" Rice NeoVim GUI init template file.
" Modified by peromage on 2021/01/22

" Rename this file to ginit.vim or gvimrc and make your own changes in it

"region Initialization
" Shortcut to open this file
let g:INIT_FILE_GUI = expand('<sfile>:p')
command! RiceInitFileGui execute 'edit '.g:INIT_FILE_GUI

" Rice global configs
"let g:RICE_CONFIGS_GUI = {
"    \ 'font': 'Cascadia Code PL:h10'
"    \ }

call RiceInitGui()
"endregion
