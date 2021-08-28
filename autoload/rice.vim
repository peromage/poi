""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rice core initializer
"
" Created by peromage 2021/02/23
" Last modified 2021/03/18
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
" NOTE: The g: should be ommitted when passed to this function
function! rice#init_var(name, value) abort
    let l:gvar = 'g:' . a:name
    if !exists(l:gvar)
        execute 'let ' . l:gvar . '=' . string(a:value)
    endif
endfunction

" Check if the given global variable exists and enabled
" NOTE: The g: should be ommitted when passed to this function
function! rice#check_var(name) abort
    let l:gvar = 'g:' . a:name
    return exists(l:gvar) && eval(l:gvar)
endfunction

" Returns a boolean indicating if the variable with the given name exists and
" the type of the value is represented as non-empty. Results will be stored in
" the out dict
" NOTE: The g: should be ommitted when passed to this function
function! rice#get_var_non_empty(name, out_dict) abort
    let l:value = get(g:, a:name, v:null)
    let a:out_dict.name = 'g:'.a:name
    let a:out_dict.value = l:value
    let a:out_dict.valid = !empty(l:value)
    return a:out_dict.valid
endfunction

" Returns a boolean indicating if the variable with the given name exists
" Results will be stored in the out dict
" NOTE: The g: should be ommitted when passed to this function
function! rice#get_var(name, out_dict) abort
    let l:value = get(g:, a:name, v:null)
    let a:out_dict.name = 'g:'.a:name
    let a:out_dict.value = l:value
    let a:out_dict.valid = l:value isnot v:null
    return a:out_dict.valid
endfunction

" Returns a boolean indicating if the file exists
function! rice#file_exists(path) abort
    return len(glob(a:path))
endfunction

"-------------------------------------------------------------------------------
" Helper commands
"-------------------------------------------------------------------------------
command! -nargs=1 IncScript call rice#source_script("<args>")
command! -nargs=1 IncRice call rice#source_script("rice/<args>")
command! -nargs=1 IncRiceInit call rice#source_script("rice/init-<args>")
command! -nargs=1 IncRicePlug call rice#source_script("rice/plug-<args>")
command! -nargs=1 IncRiceGui call rice#source_script("rice/gui-<args>")
command! -nargs=1 IncRiceMisc call rice#source_script("rice/misc-<args>")

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
    call rice#source_script('rice/main.vim')
    call plug#end()
    let s:loading = 0
endfunction

function! rice#gui_init() abort
    call rice#source_script('rice/gmain.vim')
endfunction
