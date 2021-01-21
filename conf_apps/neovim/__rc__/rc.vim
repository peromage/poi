" Rice NeoVim core config file.
" Modified by peromage on 2021/01/20

" Rice variables
let g:RICE_ROOT = expand('<sfile>:h')
let g:RICE_VIM_ROOT = expand('<sfile>:h:h')

" Rice functions
function! g:RiceModuleImport(path) abort
    " Load given modules. Wildcard is supported.
    for i in glob(a:path, 0, 1)
        execute 'source '.i
    endfor
endfunction
command! -nargs=1 RiceLoadModule execute 'source '.g:RICE_ROOT.'/modules/'.'<args>'.'.vim'
command! -nargs=1 RiceLoadPlugin execute 'source '.g:RICE_ROOT.'/plugins/'.'<args>'.'.vim'

function! g:RiceConfigInit() abort
    " Add configuration folder to runtime path
    execute 'set runtimepath+='.g:RICE_VIM_ROOT
    " Load all modules in __rc__/autoload.d directory
    call RiceModuleImport(g:RICE_ROOT.'/autoload.d/*.vim')

    " Only proceeds following when rice configuration table presents
    if !exists('g:RICE_CONFIGS') || !(v:t_dict == type(g:RICE_CONFIGS))
        return
    endif
    " Load color scheme
    let l:val = get(g:RICE_CONFIGS, 'color', 0)
    if v:t_string == type(l:val)
        execute 'colorscheme '.l:val
    endif
    " Load modules
    let l:val = get(g:RICE_CONFIGS, 'modules', 0)
    if v:t_list == type(l:val)
        for i in l:val
            execute 'RiceLoadModule '.i
        endfor
    endif
    " Load plugins via vim-plug
    call plug#begin()
    " Load pre-configured plugins
    let l:val = get(g:RICE_CONFIGS, 'plugins', 0)
    if v:t_list == type(l:val)
        for i in l:val
            execute 'RiceLoadPlugin '.i
        endfor
    endif
    " Load additional plugins
    let l:val = get(g:RICE_CONFIGS, 'plug_install', 0)
    if v:t_list == type(l:val)
        for i in l:val
            execute i
        endfor
    endif
    call plug#end()
endfunction
