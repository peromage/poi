" Rice GUI configuration
" Modified by peromage on 2021/01/23

if has('nvim')
if exists('g:loaded_rice_gui')
    finish
endif
let g:loaded_rice_gui = 1

"region Default configurations
let g:rice_gui_font = ''
"endregion

" Return code definitions from GUI initializer.
let s:checkResult = {'None': 0, 'Configured': 1, 'NotConfigured': 2}

function! rice#gui#begin()

endfunction

function! rice#gui#end()
    if rice#gui#neovimqt#init()
        return
    endif
endfunction

endif "nvim
