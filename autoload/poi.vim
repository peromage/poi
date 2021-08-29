""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Poi core initializer
"
" Created by peromage 2021/02/23
" Last modified 2021/03/18
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_poi = 1

"-------------------------------------------------------------------------------
" Meta
"-------------------------------------------------------------------------------
" poi root directory
let g:poi#home = expand('<sfile>:p:h:h')

"-------------------------------------------------------------------------------
" Helper functions
"-------------------------------------------------------------------------------

" Initialize global variable if it doesn't exist
" NOTE: The g: should be ommitted when passed to this function
function! poi#init_var(name, value) abort
    let l:gvar = 'g:' . a:name
    if !exists(l:gvar)
        execute 'let ' . l:gvar . '=' . string(a:value)
    endif
endfunction

" Load script from poi home. Path should be relative
" This file throws errors if the file does not exists
function! poi#include(rel_path) abort
    execute 'source '. simplify(g:poi#home . '/' . a:rel_path)
endfunction

" Returns a boolean indicating if the file exists
function! poi#file_exists(path) abort
    return len(glob(a:path))
endfunction

" Source any file from anywhere only if it exists
" This function does not throw errors if file does not exist
function! poi#source_if_exits(path) abort
    if poi#file_exists(a:path)
        execute 'source ' . a:path
    endif
endfunction

"-------------------------------------------------------------------------------
" Helper commands
"-------------------------------------------------------------------------------
command! -nargs=1 PoiInclude call poi#include("viml/<args>.vim")
command! -nargs=1 PoiSourceIfExists call poi#source_if_exits("<args>")
