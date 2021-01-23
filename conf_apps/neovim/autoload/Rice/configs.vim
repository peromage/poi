" Rice configuration reader
" Modified by peromage on 2021/01/23

" Loading protection flag
let s:rice_config_loading = 0

" Call this function to initialize variables that define configurations
function! rice#configs#begin() abort
    " Set flag
    let s:rice_config_loading = 1
    " Enable loading plugins via vim-plug
    call plug#begin()
endfunction

function! rice#configs#end() abort
    " Begin function must be called
    if !s:rice_config_loading
        echoe 'rice#configs#begin() must be called first!'
        return
    endif
    let s:rice_config_loading = 0
    " Load color scheme
    if g:rice_color !=# ''
        execute 'colorscheme '.g:rice_color
    endif
    " Load pre-configured plugins
    if v:t_list == type(g:rice_preplugged)
        for i in g:rice_preplugged
            execute 'RiceLoadPreplugged '.i
        endfor
    endif
    call plug#end()
endfunction
