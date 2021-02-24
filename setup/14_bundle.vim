""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Bundle settings (vim-plug)
"
" Created by peromage 2021/02/24
" Last modified 2021/02/24
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" Check enabled bundle group
"-------------------------------------------------------------------------------
let s:rt = {}
let s:enabled = {}

if !rice#get_var('rice_bundle_group', s:rt)
    let g:rice_bundle_group = []
endif

for key in g:rice_bundle_group
    let s:enabled[key] = 1
endfor

function! s:check_enabled(group) abort
    return has_key(s:enabled, a:group)
endfunction

command! -nargs=1 LoadBundle call rice#source_script("setup/bundles/<args>")

"-------------------------------------------------------------------------------
" Group: basic
"-------------------------------------------------------------------------------
if s:check_enabled('basic')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    LoadBundle coc.vim

    Plug 'Yggdroot/LeaderF', { 'do': './install.sh'}
    LoadBundle leaderf.vim

    Plug 'mhinz/vim-startify'
    LoadBundle startify.vim

    Plug 'itchyny/lightline.vim'
    LoadBundle lightline.vim
endif
