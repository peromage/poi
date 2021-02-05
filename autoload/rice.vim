" Rice core configuration
" Modified by peromage on 2021/02/05

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
" Python runtime for Vim and NeoVim
" Python refers to Python3 because Python2 is old
let g:rice_neovim_python_interpreter = ''
let g:rice_neovim_python2_interpreter = ''
let g:rice_vim_python_home = ''
let g:rice_vim_python_dll = ''
let g:rice_vim_python2_home = ''
let g:rice_vim_python2_dll = ''
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
" Returns v:null when the config variable doesn't exist or, is not the expected
" type or, is empty. Otherwise returns the value underlying that variable.
function! s:get_config_var(_name, _type) abort
    let l:_value = get(g:, a:_name, v:null)
    let l:_value_t = type(l:_value)
    if l:_value is v:null || l:_value_t != a:_type
        return v:null
    endif
    if l:_value_t == v:t_string || l:_value_t == v:t_list ||  l:_value_t == v:t_dict
        return len(l:_value) == 0 ? v:null : l:_value
    endif
    return l:_value
endfunction

" Load feature scripts under 'features' folder
function! s:load_plugging(_name) abort
    execute 'source ' . s:rice_plugging_dir . '/' . a:_name . '.vim'
endfunction

" Core config loading
function! s:init_config() abort
    " Load color scheme
    let l:_var = s:get_config_var('rice_color', v:t_string)
    if l:_var isnot v:null
        execute 'colorscheme ' . l:_var
    endif
    " Load pre-configured plugins
    let l:_var = s:get_config_var('rice_plugging', v:t_list)
    if l:_var isnot v:null
        for _iplug in l:_var
            call s:load_plugging(_iplug)
        endfor
    endif
    " Check python runtime
    if has('nvim')
        let l:_var = s:get_config_var('rice_neovim_python_interpreter', v:t_string)
        if l:_var isnot v:null
            let g:python3_host_prog = l:_var
        endif
        let l:_var = s:get_config_var('rice_neovim_python2_interpreter', v:t_string)
        if l:_var isnot v:null
            let g:python_host_prog = l:_var
        endif
    else
        let l:_var = s:get_config_var('rice_vim_python_home', v:t_string)
        if l:_var isnot v:null
            let &pythonthreehome = l:_var
        endif
        let l:_var = s:get_config_var('rice_vim_python_dll', v:t_string)
        if l:_var isnot v:null
            let &pythonthreedll = l:_var
        endif
        let l:_var = s:get_config_var('rice_vim_python2_home', v:t_string)
        if l:_var isnot v:null
            let &pythonhome = l:_var
        endif
        let l:_var = s:get_config_var('rice_vim_python2_dll', v:t_string)
        if l:_var isnot v:null
            let &pythondll = l:_var
        endif
    endif
endfunction

" Gui config loading
function! s:init_gui_config() abort
    " Set GUI font
    let l:_var = s:get_config_var('rice_gui_font', v:t_string)
    if l:_var isnot v:null
        let &guifont = l:_var
    endif
    " Select frontend
    let l:_var = s:get_config_var('rice_gui_frontend', v:t_string)
    if l:_var isnot v:null
        let l:_init_func_name = 'rice#gui#' . l:_var . '#init' . '()'
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
    let s:rice_gui_loading = 1
endfunction

function! rice#guiEnd() abort
    " Begin function must be called
    if !s:rice_gui_loading
        echoe 'rice#guiBegin() must be called first!'
        return
    endif
    let s:rice_gui_loading = 0
    call rice#gui_common#init()
    call s:init_gui_config()
endfunction
