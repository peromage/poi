" Dynamically load .vim files
function! rcore#loadvim(path, patt, ...) abort
    " @param path: A comma-separated list of directory names
    " @param patt: A comma-separated list of file glob patterns
    " @param ...: The third parameter is the default extension of module
    let l:ext = get(a:, 1, ".vim")
    for pat in split(a:patt, ',')
        let l:name = substitute(pat, '^\s*\(.\{-}\)\s*$', '\1', '')
        for m in globpath(a:path, l:name.l:ext, 0 , 1)
            execute "source ".m
        endfor
    endfor
endfunction
