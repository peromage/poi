" Rice NeoVim GUI init template file.
" Modified by peromage on 2021/01/20

" Rename this file to ginit.vim or gvimrc and make your own changes in it

"region Initialization
execute 'source '.expand('<sfile>:h').'/__rc__/grc.vim'
" Shortcut to open this file
let s:INIT_FILE_GUI = expand('<sfile>:p')
command! RiceInitFileGui execute 'edit '.s:INIT_FILE_GUI
" Rice global configs
"let g:RICE_CONFIGS_GUI = {
"    \ 'frontend': 'nvim-qt',
"    \ 'font': 'Cascadia Code PL:h10'
"    \ }
call RiceConfigInitGui()
"endregion
