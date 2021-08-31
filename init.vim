""" init.vim -- Poi Neovim bootstrap

""=============================================================================
"" Setup
""=============================================================================
execute 'set runtimepath+=' . expand('<sfile>:p:h')
let g:init_file = expand('<sfile>:p')
let g:init_local = simplify(poi#home . "/local.vim")
let g:init_local_vscode = simplify(poi#home . "/local-vscode.vim")
let g:init_coc_settings = simplify(poi#home . "/coc-settings.json")
command! OpenInitFile exec 'edit '.g:init_file

""=============================================================================
"" VSCode bootstrap
""=============================================================================
if exists('g:vscode')
    PoiInclude init-vscode
    PoiSourceIfExists init_local_vscode
    finish
endif

""=============================================================================
"" General bootstrap (use :PlugInstall for the first time)
""=============================================================================
call plug#begin(simplify(poi#home . '/vim-plugged'))

let g:python3_host_prog = 'python3'
" For Vim
"let &pythonthreehome = '/path/to/python_dir'
"let &pythonthreedll = '/path/to/python.dll'

" Core settings
PoiInclude init-settings
PoiInclude init-keybindings
PoiInclude init-commands
PoiInclude init-netrw

" Configured plugins
PoiInclude plug-theme
PoiInclude plug-navigation
PoiInclude plug-git
PoiInclude plug-typing
PoiInclude plug-coc
PoiInclude plug-terminal

""=============================================================================
"" Generates coc-settings.json if it does not exist
""=============================================================================
let s:coc_settings_json =<< EOL
{
    "$schema": "https://github.com/neoclide/coc.nvim/blob/master/data/schema.json",
    "python.pythonPath": "python",
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true,
    "clangd.path": "clangd",
    "clangd.enabled": true,
    "clangd.arguments": [
        "-j=2",
        "--background-index",
        "--clang-tidy",
        "--completion-style=bundled",
        "--pch-storage=memory",
        "--header-insertion=never",
        "--header-insertion-decorators=0"
    ],
    "powershell.integratedConsole.showOnStartup": false,
    "markdownlint.config": {
        "line-length": false
    }
}
EOL
if !poi#file_exists(init_coc_settings)
    call writefile(s:coc_settings_json, init_coc_settings, "s")
endif

""=============================================================================
"" Sources local config if it exists
""=============================================================================
call poi#source_if_exits(init_local)

call plug#end()
