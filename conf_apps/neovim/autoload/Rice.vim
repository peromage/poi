" Rice core configuration
" Modified by peromage on 2021/01/23

if has('nvim')
if exists('g:loaded_rice')
    finish
endif
let g:loaded_rice = 1

" rice root directory
let g:rice_root_dir = expand('<sfile>:h:h')
" Loading protection flag
let s:rice_loading = 0

function! rice#begin() abort
    let s:rice_loading = 1
    call rice#configs#begin()
endfunction

""" Initialization for rice """
function! rice#end() abort
    " Begin function must be called
    if !s:rice_loading
        echoe 'rice#begin() must be called first!'
        return
    endif
    let s:rice_loading = 0
    call rice#common#init()
    call rice#mappings#init()
    call rice#commands#init()
    call rice#netrw#init()
    call rice#configs#end()
endfunction

endif "nvim
