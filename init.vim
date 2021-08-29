""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Poi Neovim initialization
"
" Created by peromage 2021/02/24
" Last modified 2021/08/28
"
"
" This file should remain untouched
" General initialization (use :PlugInstall for the first time)
"
"
" Examples of configuration options (Put them in local.vim)
"
" Color scheme. Leave this unset to use default color.
"-----------------------------------------------------
"let g:poi_color = 'dracula'
"
" Check viml/init-plugs.vim' for more groups
"--------------------------------------------
"let g:poi_plug_group = ['basic', 'navigation', 'syntax', 'coc', 'git']
"
" Whether use config for VSCode integration
"------------------------------------------
"let g:poi_vscode_use_config = 1
"
" Set Python runtime for NeoVim and Vim
"-------------------------------------
" NeoVim
"let g:poi_python_interpreter = 'python3'
" Vim
"let g:poi_python_home = '/path/to/python_dir'
"let g:poi_python_dll = '/path/to/python.dll'
"
" Extra Coc plugins
" To override default extensions define this variable after poi#end()
"---------------------------------------------------------------------
"let g:coc_global_extensions = [
"\   'coc-clangd',
"\   'coc-powershell',
"\   'coc-tsserver',
"\   'coc-pyright'
"\   ]
"
" Extra plugins via vim-plug
" To override default bundles define vim-plug after poi#end()
"-------------------------------------------------------------
"Plug 'Kenta11/helloworld-vim'
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:init_home = expand('<sfile>:p:h')
let g:init_file = expand('<sfile>:p')
let g:init_local = simplify(init_home . "/local.vim")
let g:init_local_vscode = simplify(init_home . "/local-vscode.vim")
let g:init_coc_settings = simplify(init_home . "/coc-settings.json")
command! OpenInitFile exec 'edit '.g:init_file
execute 'set rtp+='.g:init_home

" Bootstrap

if exists('g:vscode')
    let g:poi_vscode_use_config = 1
    PoiInclude init-vscode
else
    call poi#begin()

    let g:poi_color = 'dracula'
    let g:poi_plug_group = ['basic', 'navigation', 'syntax', 'coc', 'git']
    let g:poi_python_interpreter = 'python3'

    " coc-settings.json
    let s:coc_settings_json =<< EOL
{
    "$schema": "https://github.com/neoclide/coc.nvim/blob/master/data/schema.json",
    "python.pythonPath": "python",
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true,
    "clangd.path": "clangd",
    "clangd.enabled": true,
    "clangd.arguments": ["--background-index"],
    "powershell.integratedConsole.showOnStartup": false,
    "markdownlint.config": {
        "line-length": false
    }
}
EOL

    " Load configs first
    PoiInclude init-configvars
    PoiInclude init-settings
    PoiInclude init-keybindings
    PoiInclude init-commands
    PoiInclude init-netrw
    PoiInclude init-plugs


    " Generates coc-settings.json if it does not exist
    if !poi#file_exists(init_coc_settings)
        call writefile(s:coc_settings_json, init_coc_settings, "s")
    endif

    " Sources local config if it exists
    PoiSourceIfExists init_local

    call poi#end()
endif
