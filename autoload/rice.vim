" Rice core configuration
" Modified by peromage on 2021/02/22

if exists('g:loaded_rice')
    finish
endif
let g:loaded_rice = 1

" Global configuration variables
" ------------------------------------------------------------------------------
" Color scheme
let g:rice_color = 'dracula'
" Array of strings. Prevent loading pre-configured plugins in rice/boost.
let g:rice_disabled_boost = []
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
let s:rice_vim_root_dir = expand('<sfile>:h:h')
let s:rice_boost_dir = s:rice_root_dir . '/boost'
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
    " Support checks for string, list, dict for now
    if l:_value_t == v:t_string || l:_value_t == v:t_list ||  l:_value_t == v:t_dict
        return len(l:_value) == 0 ? v:null : l:_value
    endif
    return l:_value
endfunction

" Load color scheme
function! s:load_colorscheme() abort
    let l:_var = s:get_config_var('rice_color', v:t_string)
    if l:_var isnot v:null
        execute 'colorscheme ' . l:_var
    endif
endfunction

" Load pre-configured plugins under 'boost' folder
function! s:load_boost() abort
    let l:_var = s:get_config_var('rice_disabled_boost', v:t_list)
    " Default boost
    let l:_boost = glob(s:rice_boost_dir . '/*.vim', 0, 1)
    " Disable boosts from the list
    if l:_var isnot v:null
        for _name in l:_var
            call filter(l:_boost, 'v:val !~# "' . _name . '"')
        endfor
    endif
    " Load
    for _name in l:_boost
        execute 'source ' . _name
    endfor
endfunction

" Set python runtime path
function! s:load_python() abort
    if has('nvim')
        let l:_var = s:get_config_var('rice_neovim_python_interpreter', v:t_string)
        if l:_var isnot v:null
            let g:python3_host_prog = l:_var
        endif
        let l:_var = s:get_config_var('rice_neovim_python2_interpreter', v:t_string)
        if l:_var isnot v:null
            let g:python_host_prog = l:_var
        endif
    " Vim
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

" Set GUI font
function! s:load_gui_font() abort
    let l:_var = s:get_config_var('rice_gui_font', v:t_string)
    if l:_var isnot v:null
        let &guifont = l:_var
    endif
endfunction

" Select frontend
function! s:load_gui_frontend() abort
    let l:_var = s:get_config_var('rice_gui_frontend', v:t_string)
    if l:_var isnot v:null
        let l:_init_func_name = 'rice#gui#' . l:_var . '#init' . '()'
        execute 'call ' . l:_init_func_name
    endif
endfunction

" Core config loading
function! s:init_config() abort
    call s:load_colorscheme()
    call s:load_python()
    call s:load_boost()
endfunction

" Gui config loading
function! s:init_gui_config() abort
    call s:load_gui_font()
    call s:load_gui_frontend()
endfunction

" Public functions
" ------------------------------------------------------------------------------

function! rice#begin(...) abort
    let s:rice_loading = 1
    " Directory to put plugin and plugin configuration (e.g. vim-plug, Coc)
    let l:_data_dir = a:0 > 0 ? a:1 : s:rice_vim_root_dir
    call plug#begin(simplify(l:_data_dir . '/vim-plugged'))
    let g:coc_config_home = l:_data_dir
    let g:coc_data_home = simplify(l:_data_dir . '/coc-extensions')
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
