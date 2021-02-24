"===============================================================================
"
" Rice setup entry
"
" Created by peromage 2021/02/23
" Last modified 2021/02/23
"
"===============================================================================

"-------------------------------------------------------------------------------
" This works with rice lib
"-------------------------------------------------------------------------------
if !exists('g:loaded_rice') && !g:loaded_rice | finish | endif
command! -nargs=1 LoadSetup call rice#source_script("setup/<args>")

"-------------------------------------------------------------------------------
" Read global config variables
"-------------------------------------------------------------------------------
let s:rt = {}

" Color
if rice#get_var('rice_color', s:rt)
    execute 'colorscheme ' . s:rt.value
else
    colorscheme dracula
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

"-------------------------------------------------------------------------------
" Load components
"-------------------------------------------------------------------------------
LoadSetup 10_sets.vim
LoadSetup 11_keymaps.vim
LoadSetup 12_commands.vim
LoadSetup 13_netrw.vim
LoadSetup 14_bundle.vim
