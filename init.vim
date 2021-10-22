""" init.vim -- Poi Neovim bootstrap

""------------------------------------------------------------------------------
"" Initialization
""------------------------------------------------------------------------------

exec 'set runtimepath+=' . expand('<sfile>:p:h')
call poi#init()

""------------------------------------------------------------------------------
"" VSCode bootstrap. Do not load the following packages
""------------------------------------------------------------------------------

if exists('g:vscode')
    PoiInclude init-vscode
    call poi#source_if_exits(simplify(poi#home_dir . "/local-vscode.vim"))
    finish
endif

""------------------------------------------------------------------------------
"" General bootstrap (use :PlugInstall for the first time)
""------------------------------------------------------------------------------

call poi#begin()

"" Python supports
let g:python3_host_prog = 'python3'
"" For Vim
"let &pythonthreehome = '/path/to/python_dir'
"let &pythonthreedll = '/path/to/python.dll'

"" Core settings
PoiInclude init-lib
PoiInclude init-keymap
PoiInclude init-config

"" Configured plugins
PoiInclude plug-theme
PoiInclude plug-git
PoiInclude plug-navigation
PoiInclude plug-coding
PoiInclude plug-terminal

"" Local config files
WriteCocSettingsJson
call poi#source_if_exits(simplify(poi#home_dir . "/local.vim"))

call poi#end()
