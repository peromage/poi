" Configuration for neovim-qt
" Modified by peromage on 2021/02/04

function! rice#gui#gvim#init() abort
    if !has('gui_running')
        return 0
    endif

    return 1
endfunction
