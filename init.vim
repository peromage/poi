""" init.vim -- Poi Neovim bootstrap

""------------------------------------------------------------------------------
"" Initialization
""------------------------------------------------------------------------------

let g:poi = {}
let poi.loaded = 1
let poi.home_dir = expand('<sfile>:p:h')
let poi.local_file = simplify(poi.home_dir . "/local.vim")
let poi.local_vscode_file = simplify(poi.home_dir . "/local-vscode.vim")
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
"" Local config files
""------------------------------------------------------------------------------

WriteCocSettingsJson
call poi#source_if_exits(poi.local_file)

call plug#end()
