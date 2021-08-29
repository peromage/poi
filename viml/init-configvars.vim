""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Poi configuration loader
"
" Created by peromage 2021/03/14
" Last modified 2021/03/18
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:rt = {}

"-------------------------------------------------------------------------------
" Color
"-------------------------------------------------------------------------------
if poi#get_var('poi_color', s:rt)
    execute 'colorscheme ' . s:rt.value
endif

"-------------------------------------------------------------------------------
" Python runtime for NeoVim and Vim. Python2 is deprecated
"-------------------------------------------------------------------------------
if has('nvim')
    if poi#get_var('poi_python_interpreter', s:rt)
        let g:python3_host_prog = s:rt.value
    endif
else
    if poi#get_var('poi_python_home', s:rt)
        let &pythonthreehome = s:rt.value
    endif
    if poi#get_var('poi_python_dll', s:rt)
        let &pythonthreedll = s:rt.value
    endif
endif
