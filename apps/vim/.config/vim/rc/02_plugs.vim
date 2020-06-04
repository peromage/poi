" Vim-plug registration
" Dict key corresponds a plug configuration file in 'rc_plugs' directory
" Such as coc.vim
" Each function defines how to load the plugin in vim-plug way
" User must call 'RCPlug.Load()' between 'call plug#begin()' and 'call plug#end()'
" And call 'RCPlug.LoadConfig()' to load the plugin configuration
let g:RCPlugs = {}
let g:RCPlugs.LoadingList = []

" Plugin initialization
function! g:RCPlugs.Load(plug_list) abort
    " @param plug_list: list of plugins that need to be loaded
    " Clean buffer list
    let self.LoadingList = []
    for ppp in a:plug_list
        call self[ppp]()
        call add(self.LoadingList, ppp)
    endfor
endfunction

" Plugin configuration loading
function! g:RCPlugs.LoadConf() abort
    call RCLoadModule(g:RCROOT."/rc_plugs", self.LoadingList, ".vim")
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
