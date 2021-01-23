" Rice configuration reader
" Modified by peromage on 2021/01/23

"region Default configurations
" Color scheme
let g:rice_config_color = ''
" Array of strings. Loads pre-configured plugins in g:rice_root_dir/preplugged.
let g:rice_config_preplugged = []
"endregion

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
    if g:rice_config_color !=# ''
        execute 'colorscheme '.g:rice_config_color
    endif
    " Load pre-configured plugins
    if v:t_list == type(g:rice_config_preplugged)
        for i in g:rice_config_preplugged
            execute 'RiceLoadPreplugged '.i
        endfor
    endif
    call plug#end()
endfunction
