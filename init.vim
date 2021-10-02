""" init.vim -- Poi Neovim bootstrap

""------------------------------------------------------------------------------
"" Initialization
""------------------------------------------------------------------------------

let g:poi = {}
let poi.loaded = 1
let poi.home_dir = expand('<sfile>:p:h')
let poi.local_file = simplify(poi.home_dir . "/local.vim")
let poi.local_vscode_file = simplify(poi.home_dir . "/local-vscode.vim")
let poi.coc_settings_file = simplify(poi.home_dir . "/coc-settings.json")
exec 'set runtimepath+=' . poi.home_dir
call poi#init()

""------------------------------------------------------------------------------
"" VSCode bootstrap. Do not load the following packages
""------------------------------------------------------------------------------

if exists('g:vscode')
    PoiInclude init-vscode
    call poi#source_if_exits(poi.local_vscode_file)
    finish
endif

""------------------------------------------------------------------------------
"" General bootstrap (use :PlugInstall for the first time)
""------------------------------------------------------------------------------

call plug#begin(simplify(poi.home_dir . '/vim-plugged'))

let g:python3_host_prog = 'python3'
"" For Vim
"let &pythonthreehome = '/path/to/python_dir'
"let &pythonthreedll = '/path/to/python.dll'

"" Core settings
PoiInclude init-lib
PoiInclude init-config
PoiInclude init-keys
PoiInclude init-netrw

"" Configured plugins
PoiInclude plug-theme
PoiInclude plug-navigation
PoiInclude plug-git
PoiInclude plug-typing
PoiInclude plug-coc
PoiInclude plug-terminal

""------------------------------------------------------------------------------
"" Generates coc-settings.json if it does not exist
""------------------------------------------------------------------------------

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

if !poi#file_exists(poi.coc_settings_file)
    call writefile(s:coc_settings_json, poi.coc_settings_file, "s")
endif

""------------------------------------------------------------------------------
"" Sources local config if it exists
""------------------------------------------------------------------------------

call poi#source_if_exits(poi.local_file)

call plug#end()
