" Dynamically load .vim files
function! g:RCLoadModule(path, patterns, ...) abort
    " @param path: Directory names
    " @param patterns: List of file glob patterns
    " @param ...: The third parameter is the default extension of module
    let l:ext = get(a:, 1, ".vim")
    "for pat in split(a:patt, ',')
        "let l:name = substitute(pat, '^\s*\(.\{-}\)\s*$', '\1', '')
        "for m in globpath(a:path, l:name.l:ext, 0 , 1)
            "execute "source ".m
        "endfor
    "endfor
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
    call RCLoadModule(g:RCROOT."/autoload_confs", ["*"])
endfunction

" Vim-plug registration
" Dict key corresponds a plug configuration file in 'autoload_confs' directory
" Such as "coc.vim"
" Each function defines how to load the plugin in vim-plug way
" User must call 'RCPlug.Init()' between 'call plug#begin()' and 'call plug#end()'
" And call 'RCPlug.Load()' to load the plugin configuration
let g:RCPlugs = {}
let g:RCPlugs.LoadList = []

" Plugin initialization
function! g:RCPlugs.Init(pp) abort
    " @param pp: comma separated list of plugins that need to be loaded
    " Clean buffer list
    let self.LoadList = []
    for ppp in a:pp
        call self[ppp]()
        call add(self.LoadList, ppp)
    endfor
endfunction

" Plugin configuration loading
function! g:RCPlugs.Load() abort
    call RCLoadModule(g:RCROOT."/plugin_confs", self.LoadList, ".vim")
endfunction

""" Begin plugin registration
" Plug: defx
function g:RCPlugs.defx()
    if has('nvim')
        Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/defx.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
endfunction

" Plug: nerdtree
function g:RCPlugs.nerdtree()
    Plug 'preservim/nerdtree'
endfunction

" Plug: coc
function g:RCPlugs.coc()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endfunction

" Plug: dracula theme
function g:RCPlugs.dracula()
    Plug 'dracula/vim', { 'as': 'dracula' }
endfunction

" Plug: leaderf
function g:RCPlugs.leaderf()
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh'}
endfunction

" Plug: fzf
function g:RCPlugs.fzf()
    Plug 'junegunn/fzf.vim'
endfunction

""" End plugin registration

call RCInit()
