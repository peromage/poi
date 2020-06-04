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

" Load all customized configs
function! g:RCInit() abort
    " Load all modules in rc directory
    call RCLoadModule(g:RCROOT."/rc", ["*"])
endfunction

"""" Start initialization
call RCInit()
