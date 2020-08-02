""
"" Created by peromage on 2020/06/04
""
"" RC entry file
""

" Guard for repeat loading
if get(g:, "RC_INIT", 0) != 0
    echom "RC already loaded"
    finish
else
    let g:RC_INIT = 1
endif

" Rc file root directory
let g:RC_ROOT = resolve(expand('<sfile>:h'))

" A helper function that dynamically loads .vim files by given directory
" and name patterns
function! g:RCLoad(path, patterns, ...) abort
    " @param path: Directory names
    " @param patterns: List of file glob patterns
    " @param ...: The third parameter is the default extension of module
    let l:ext = get(a:, 1, ".vim")
    for patt in a:patterns
        for mpath in globpath(a:path, patt.l:ext, 0, 1)
            execute "source ".mpath
        endfor
    endfor
endfunction

" A command that loads modules in __rcmodules__
command! -nargs=1 RCLoadModule execute "source ".g:RC_ROOT."/__rcmodules__/"."<args>".".vim"

" RC main function
function! g:RCInit() abort
    " Load global configurations
    "
    " Add rc folder to runtime path
    execute "set runtimepath+=".g:RC_ROOT
    " Load all modules in rc directory
    call RCLoad(g:RC_ROOT."/__rc__", ["*"])

    " Handle global configuration variables
    "
    " Set g:RC_Color to override default color scheme
    " This variable is a string
    if exists("g:RC_Color")
        execute "colorscheme ".g:RC_Color
    endif
    " Set g:RC_Plugs_Custom to load the plugins in __rcplugs__ with customized
    " configurations. The names must be the same as the module file names.
    " This variable is an array of strings.
    if !exists("g:RC_Plugs_Custom")
        let g:RC_Plugs_Custom = []
    endif
    " Set g:RC_Plugs to load the plugins that users desire.
    " This variable is a list of strings where each string is a vim-plug style
    " loading expression
    if !exists("g:RC_Plugs")
        let g:RC_Plugs = []
    endif
    " Load plugins via vim-plug
    call plug#begin()
    call RCLoad(g:RC_ROOT."/__rcplugs__", g:RC_Plugs_Custom)
    for vppp in g:RC_Plugs
        execute vppp
    endfor
    call plug#end()
endfunction

"""" Start initialization
call RCInit()
