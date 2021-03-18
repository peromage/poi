""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rice GUI configuration loader
"
" Created by peromage 2021/03/14
" Last modified 2021/03/18
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:rt = {}

"-------------------------------------------------------------------------------
" Font
"-------------------------------------------------------------------------------
if rice#get_var('rice_gui_font', s:rt)
    let &guifont = s:rt.value
endif

"-------------------------------------------------------------------------------
" GUI configs
"-------------------------------------------------------------------------------
" Functions to check GUI configs
function! s:use_neovim_config()
    if exists('g:GuiLoaded')
        let l:fname = 'neovimqt'
    elseif exists('g:fvim_loaded')
        let l:fname = 'fvim'
    else
        return
    endif
    execute 'IncRiceGui ' . l:fname . '.vim'
endfunction

function! s:use_vim_config()
    if has('gui_running')
        let l:fname = 'gvim'
    else
        return
    endif
    execute 'IncRiceGui ' . l:fname . '.vim'
endfunction

" Load GUI applications config
if rice#get_var('rice_gui_use_config', s:rt) && s:rt.value
    if has('nvim')
        call s:use_neovim_config()
    else
        call s:use_vim_config()
    endif
endif
