""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rice configuration loader
"
" Created by peromage 2021/03/14
" Last modified 2021/03/14
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" Read global config variables
"-------------------------------------------------------------------------------
let s:rt = {}

" Color
if rice#get_var('rice_color', s:rt)
    execute 'colorscheme ' . s:rt.value
endif

" Python runtime for Vim and NeoVim
" Python refers to Python3 because Python2 is old
if has('nvim')
    if rice#get_var('rice_neovim_python_interpreter', s:rt)
        let g:python3_host_prog = s:rt.value
    endif
    if rice#get_var('rice_neovim_python2_interpreter', s:rt)
        let g:python_host_prog = s:rt.value
    endif
" Vim
else
    if rice#get_var('rice_vim_python_home', s:rt)
        let &pythonthreehome = s:rt.value
    endif
    if rice#get_var('rice_vim_python_dll', s:rt)
        let &pythonthreedll = s:rt.value
    endif
    if rice#get_var('rice_vim_python2_home', s:rt)
        let &pythonhome = s:rt.value
    endif
    if rice#get_var('rice_vim_python2_dll', s:rt)
        let &pythondll = s:rt.value
    endif
endif
