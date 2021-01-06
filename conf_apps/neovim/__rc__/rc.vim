"""""""""""""""""""""""""""""""""""""""
"" Created by peromage on 2020/08/03 ""
"""""""""""""""""""""""""""""""""""""""
""
"" RC core initialization file
""

" Guard for repeat loading
if get(g:, "RC_INIT", 0) != 0 | finish | endif

" RC variables
let g:RC_INIT = 1
let g:RC_ROOT = expand('<sfile>:h')
let g:RC_CONFIG_ROOT = expand('<sfile>:h:h')

" A helper function that dynamically loads .vim files by given directory
" and name patterns
" @param path: Directory names
" @param patterns: List of file glob patterns
" @param ...: The third parameter is the default extension of module
function! g:RCLoad(path, patterns, ...) abort
    let l:ext = get(a:, 1, ".vim")
    for patt in a:patterns
        for mpath in globpath(a:path, patt.l:ext, 0, 1)
            execute "source ".mpath
        endfor
    endfor
endfunction

" A command that loads modules in __rc__/modules
command! -nargs=1 RCLoadModule execute "source ".g:RC_ROOT."/modules/"."<args>".".vim"

" Start initialization

" Add configuration folder to runtime path
execute "set runtimepath+=".g:RC_CONFIG_ROOT

" Load all modules in __rc__/autoload.d directory
call RCLoad(g:RC_ROOT."/autoload.d", ["*"])

" Handle global configuration variables
"
" Set g:RC_Color to override default color scheme
" This variable is a string
if exists("g:RC_Color")
    execute "colorscheme ".g:RC_Color
endif

" Load plugins via vim-plug
call plug#begin()
" Set g:RC_Plugins to load the plugins in __rc__/plugins with customized
" configurations. The names must be the same as the module file names.
" This variable is an array of strings.
if exists("g:RC_Plugins")
    call RCLoad(g:RC_ROOT."/plugins", g:RC_Plugins)
endif
" Set g:RC_Plugins_Extra to load the plugins that users desire.
" This variable is a list of strings where each string is a vim-plug style
" loading expression
if exists("g:RC_Plugins_Extra")
    for vppp in g:RC_Plugins_Extra
        execute vppp
    endfor
endif
call plug#end()

" Load RC modules in __rc__/modules
if exists("g:RC_Modules")
    call RCLoad(g:RC_ROOT."/modules", g:RC_Modules)
endif
