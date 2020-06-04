" Dynamically load .vim files
function! g:RCLoadModule(path, patterns, ...) abort
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

" Rc file root directory
let g:RCROOT = resolve(expand('<sfile>:h'))

" RC main function
function! g:RCInit() abort
    " Load all modules in rc directory
    call RCLoadModule(g:RCROOT."/rc", ["*"])

    " Set g:RC_Global_Plugs to empty to prevent loading default plugins
    " Or customize the pre-configured plugins
    if !exists("g:RC_Global_Plugs")
        let g:RC_Global_Plugs = ["coc", "leaderf"]
    endif

    " Set g:RC_Local_Plugs to load cusmized plugins by users
    " This variable is a list of strings where each string is a vim-plug style
    " loading expression
    if !exists("g:RC_Local_Plugs")
        let g:RC_Local_Plugs = []
    endif

    " Load plugins via vim-plug
    call plug#begin()
    call RCLoadModule(g:RCROOT."/rc_plugs", g:RC_Global_Plugs)
    for vppp in g:RC_Local_Plugs
        execute vppp
    endfor
    call plug#end()
endfunction

"""" Start initialization
"call RCInit()
