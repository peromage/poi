" Rice commands
" Modified by peromage on 2021/01/23

function! rice#commands#init() abort
    " Close all but current buffers
    command! Bdall :%bd|e#
    " Toggle line numbers
    command! ShowLines :set nu rnu scl=yes
    command! NoShowLines :set nonu nornu scl=no
    " Toggle paste mode
    command! PasteMode :set paste
    command! NoPasteMode :set nopaste
    command! -nargs=1 RiceLoadOndemand call rice#loadOndemand(<f-args>)
endfunction
