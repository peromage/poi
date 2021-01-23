" Rice core configuration
" Modified by peromage on 2021/01/23

if has('nvim')
if exists('g:loaded_rice')
    finish
endif
let g:loaded_rice = 1

"region Default configurations
" rice root directory
let g:rice_root_dir = expand('<sfile>:h:h')
" Color scheme
let g:rice_color = ''
" Array of strings. Loads pre-configured plugins in g:rice_root_dir/preplugged.
let g:rice_ondemand = []
" Prefered GUI font
let g:rice_gui_font = ''
"endregion

" Loading protection flag
let s:rice_loading = 0
let s:rice_gui_loading = 0
" Return code definitions from GUI initializer.
let s:checkResult = {'None': 0, 'Configured': 1, 'NotConfigured': 2}

function! rice#begin() abort
    let s:rice_loading = 1
    call rice#configs#begin()
endfunction

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

function! rice#guiBegin() abort

endfunction

function! rice#guiEnd() abort
    if rice#gui#neovimqt#init()
        return
    endif
endfunction

function! rice#loadOndemand(name) abort
    execute 'source '.g:rice_root_dir.'/ondemand/'.a:name.'.vim'
endfunction

endif "nvim
