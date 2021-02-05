" Rice core configuration
" Modified by peromage on 2021/02/04

if exists('g:loaded_rice')
    finish
endif
let g:loaded_rice = 1

" Global configuration variables
" ------------------------------------------------------------------------------
" Color scheme
let g:rice_color = ''
" Array of strings. Loads pre-configured plugins in rice/plugging.
let g:rice_plugging = []
" GUI related
let g:rice_gui_font = ''
let g:rice_gui_frontend = ''

" Internal
" ------------------------------------------------------------------------------
" rice root directory
let s:rice_root_dir = simplify(expand('<sfile>:h') . '/rice')
let s:rice_plugging_dir = s:rice_root_dir . '/plugging'
let s:rice_gui_dir = s:rice_root_dir . '/gui'
" Loading protection flag
let s:rice_loading = 0
let s:rice_gui_loading = 0
" Return code definitions from GUI initializer.
let s:checkResult = {'None': 0, 'Configured': 1, 'NotConfigured': 2}

" Loader to read config variables
" ------------------------------------------------------------------------------
" Returns false when the config variable doesn't exist or, is not the expected
" type or, is empty
function! s:validate_config_var(_name, _type) abort
    let l:_value = get(g:, a:_name, v:null)
    let l:_value_t = type(l:_value)
    if l:_value is v:null || l:_value_t != a:_type
        return v:false
    endif
    if l:_value_t == v:t_string
        return l:_value !=# ''
    endif
    if l:_value_t == v:t_list ||  l:_value_t == v:t_dict
        return len(l:_value) != 0
    endif
    return v:true
endfunction

" Load feature scripts under 'features' folder
function! s:load_plugging(_name) abort
    execute 'source ' . s:rice_plugging_dir . '/' . a:_name . '.vim'
endfunction

function! s:init_config() abort
    " Load color scheme
    if s:validate_config_var('rice_color', v:t_string)
        execute 'colorscheme '.g:rice_color
    endif
    " Load pre-configured plugins
    if s:validate_config_var('rice_plugging', v:t_list)
        for _iplug in g:rice_plugging
            call s:load_plugging(_iplug)
        endfor
    endif
endfunction

function! s:init_gui_config() abort
    " Set GUI font
    if s:validate_config_var('rice_gui_font', v:t_string)
        let &guifont = g:rice_gui_font
    endif
    " Select frontend
    if s:validate_config_var('rice_gui_frontend', v:t_string)
        let l:_init_func_name = 'rice#gui#' . g:rice_gui_frontend . '#init' . '()'
        execute 'call ' . l:_init_func_name
    endif
endfunction

" Public functions
" ------------------------------------------------------------------------------

function! rice#begin() abort
    let s:rice_loading = 1
    call plug#begin()
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
    call s:init_config()
    call plug#end()
endfunction

function! rice#guiBegin() abort

endfunction

function! rice#guiEnd() abort
    call s:init_gui_config()
endfunction
