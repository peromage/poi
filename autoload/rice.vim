""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rice core initializer
"
" Created by peromage 2021/02/23
" Last modified 2021/02/23
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('g:loaded_rice')
    finish
endif
let g:loaded_rice = 1

"-------------------------------------------------------------------------------
" Meta
"-------------------------------------------------------------------------------
" rice root directory
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

"-------------------------------------------------------------------------------
" Helper functions
"-------------------------------------------------------------------------------
" Load script from rice home. Path should be relative
function! rice#source_script(rel_path) abort
    execute 'source '. fnameescape(s:home . '/' . a:rel_path)
endfunction

" Initialize global variable if it doesn't exist
function! rice#init_var(var, value) abort
    let l:gvar = 'g:' . a:var
    if !exists(l:gvar)
        execute 'let ' . l:gvar . '=' . string(a:value)
    endif
endfunction

" Returns false when the config variable doesn't exist or, is not the expected
" type or, is empty. Otherwise returns true
" Results will be stored in the out dict
function! rice#validate_var(var_name, type, out_dict) abort
    let l:value = get(g:, a:var_name, v:null)
    let l:value_t = type(l:value)
    let a:out_dict.name = 'g:'.a:var_name
    let a:out_dict.value = l:value
    let a:out_dict.type = l:value_t
    let a:out_dict.valid = l:value isnot v:null || l:value_t == a:type
    " Non-empty checks
    " Support checks for string, list, dict for now
    if a:out_dict.valid
        if l:value_t == v:t_string || l:value_t == v:t_list ||  l:value_t == v:t_dict
            let a:out_dict.valid = len(l:value) != 0
        endif
    endif
    return a:out_dict.valid
endfunction

" Returns true if the variable exists
" Results will be stored in the out dict
function! rice#get_var(var_name, out_dict) abort
    let l:value = get(g:, a:var_name, v:null)
    let a:out_dict.name = 'g:'.a:var_name
    let a:out_dict.value = l:value
    let a:out_dict.valid = l:value isnot v:null
    return a:out_dict.valid
endfunction

"-------------------------------------------------------------------------------
" Helper commands
"-------------------------------------------------------------------------------
command! -nargs=1 IncScript call rice#source_script("<args>")
command! -nargs=1 IncBootstrapInit call rice#source_script("bootstrap/init-<args>")
command! -nargs=1 IncBootstrapPlug call rice#source_script("bootstrap/plug-<args>")
command! -nargs=1 IncBootstrapGui call rice#source_script("bootstrap/gui-<args>")

"-------------------------------------------------------------------------------
" Initializers
"-------------------------------------------------------------------------------
" Loading protection flag
let s:loading = 0

function! rice#begin(...) abort
    let s:loading = 1
    " Directory to put plugin and plugin configuration (e.g. vim-plug, Coc)
    let l:data_dir = a:0 > 0 ? a:1 : s:home
    call plug#begin(simplify(l:data_dir . '/vim-plugged'))
    let g:coc_data_home = simplify(l:data_dir . '/coc-extensions')
    let g:coc_config_home = l:data_dir
endfunction

function! rice#end() abort
    " Begin function must be called
    if !s:loading
        echoe 'rice#begin() must be called first!'
        return
    endif
    call rice#source_script('bootstrap/main.vim')
    call plug#end()
    let s:loading = 0
endfunction

function! rice#gui_init() abort
    call rice#source_script('bootstrap/gmain.vim')
endfunction
