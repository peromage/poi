" Rice editor common settings
" Modified by peromage on 2021/02/04

function! rice#gui_common#init() abort
    " Balanced looking
    set guioptions=egmrLtT
    " Always starts GUI in home directory
    cd $HOME
endfunction
