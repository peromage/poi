"""""""""""""""""""""""""""""""""""""""
"" Created by peromage on 2020/06/04 ""
"""""""""""""""""""""""""""""""""""""""
""
"" init.vim template
"" Rename this file to "init.vim" or "vimrc" and make your own changes in it
""

"#region User Configurations

" Override these variables to control RC behaviors
"
"let g:RC_Color = "dracula"
"let g:RC_Plugs_Custom = ["coc", "leaderf"]
"let g:RC_Plugs = [
"            \ "Plug 'sheerun/vim-polyglot'"
"            \ ]
"let g:RC_Coc_Extensions = [
"            \ "coc-explorer",
"            \ "coc-tabnine",
"            \ "coc-snippets",
"            \ "coc-git",
"            \ "coc-json",
"            \ "coc-markdownlint",
"            \ "coc-vimlsp",
"            \ "coc-clangd",
"            \ "coc-powershell",
"            \ "coc-tsserver",
"            \ "coc-python"
"            \ ]
"let g:RC_Modules = ["spacevim-statusline"]

" Runtime paths for plugins
"
"set runtimepath+=/home/linuxbrew/.linuxbrew/opt/fzf
"let g:python3_host_prog="/usr/bin/python3"
"let g:python_host_prog="/usr/bin/python2"

" Uncomment this to enable force initialization
"let g:RC_INIT = 0

"#endregion


"===============================================================================


"#region Initialization Do Not Touch

" Guard for repeat loading
if get(g:, "RC_INIT", 0) != 0 | finish | endif

" RC variables
let g:RC_INIT = 1
let g:RC_ROOT = expand('<sfile>:h')

" Shortcut to open this file
let s:INIT_FILE = expand("<sfile>:p")
command! RCConfig execute "edit ".s:INIT_FILE

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

" A command that loads modules in __rcmodules__
command! -nargs=1 RCLoadModule execute "source ".g:RC_ROOT."/__rcmodules__/"."<args>".".vim"

" Start initialization

" Add rc folder to runtime path
execute "set runtimepath+=".g:RC_ROOT
" Load all modules in __rc__ directory
call RCLoad(g:RC_ROOT."/__rc__", ["*"])

" Handle global configuration variables
"
" Set g:RC_Color to override default color scheme
" This variable is a string
if exists("g:RC_Color")
    execute "colorscheme ".g:RC_Color
endif

" Load plugins via vim-plug
call plug#begin()
" Set g:RC_Plugs_Custom to load the plugins in __rcplugs__ with customized
" configurations. The names must be the same as the module file names.
" This variable is an array of strings.
if exists("g:RC_Plugs_Custom")
    call RCLoad(g:RC_ROOT."/__rcplugs__", g:RC_Plugs_Custom)
endif
" Set g:RC_Plugs to load the plugins that users desire.
" This variable is a list of strings where each string is a vim-plug style
" loading expression
if exists("g:RC_Plugs")
    for vppp in g:RC_Plugs
        execute vppp
    endfor
endif
call plug#end()

" Load Extra modules
if exists("g:RC_Modules")
    call RCLoad(g:RC_ROOT."/__rcmodules__", g:RC_Modules)
endif

"#endregion
