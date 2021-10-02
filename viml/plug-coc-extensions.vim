""" plug-coc-extensions.vim -- Coc extensions

""------------------------------------------------------------------------------
"" Default COC directory
""------------------------------------------------------------------------------

let g:coc_data_home = simplify(poi.home_dir . '/coc-extensions')
let g:coc_config_home = poi.home_dir

""------------------------------------------------------------------------------
"" Default COC extensions
""------------------------------------------------------------------------------

let g:coc_global_extensions = [
\   'coc-explorer',
\   'coc-tabnine',
\   'coc-snippets',
\   'coc-git',
\   'coc-json',
\   'coc-markdownlint',
\   'coc-vimlsp',
\   'coc-clangd',
\   'coc-powershell',
\   'coc-tsserver',
\   'coc-pyright'
\   ]

""------------------------------------------------------------------------------
"" Default extension config
""------------------------------------------------------------------------------

function! s:write_coc_settings_json() abort
    let l:coc_settings_json_file = simplify(g:poi.home_dir . '/coc-settings.json')
    let l:coc_settings_json =<< EOL
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
    if !poi#file_exists(l:coc_settings_json_file)
        call writefile(l:coc_settings_json, l:coc_settings_json_file, 's')
    endif
endfunction

command! WriteCocSettingsJson call <SID>write_coc_settings_json()

""------------------------------------------------------------------------------
"" File explorer
""------------------------------------------------------------------------------

let g:coc_explorer_global_presets = {
\   'left' : {
\       'toggle': v:true,
\       'focus': v:true,
\       'open-action-strategy': 'select',
\       'quit-on-open': v:false,
\       'sources': [
\           { 'name': 'buffer', 'expand': v:false },
\           { 'name': 'file', 'expand': v:true }
\       ],
\       'position': 'left',
\       'width': 40,
\       'content-width-type': 'vim-width',
\   },
\   'right' : {
\       'toggle': v:true,
\       'focus': v:true,
\       'open-action-strategy': 'select',
\       'quit-on-open': v:false,
\       'sources': [
\           { 'name': 'buffer', 'expand': v:false },
\           { 'name': 'file', 'expand': v:true }
\       ],
\       'position': 'right',
\       'width': 40,
\       'content-width-type': 'vim-width',
\   },
\   'floating' : {
\       'toggle': v:true,
\       'focus': v:true,
\       'open-action-strategy': 'sourceWindow',
\       'quit-on-open': v:true,
\       'sources': [
\           { 'name': 'buffer', 'expand': v:false },
\           { 'name': 'file', 'expand': v:true }
\       ],
\       'position': 'floating',
\       'content-width-type': 'win-width',
\       'floating-position': 'center'
\   },
\   'tab' : {
\       'toggle': v:true,
\       'focus': v:true,
\       'open-action-strategy': 'sourceWindow',
\       'quit-on-open': v:true,
\       'sources': [
\           { 'name': 'buffer', 'expand': v:false },
\           { 'name': 'file', 'expand': v:true }
\       ],
\       'position': 'tab',
\       'content-width-type': 'vim-width'
\   }
\ }

nnoremap <silent> <Leader>dd :<C-U>CocCommand explorer --preset left<CR>
nnoremap <silent> <Leader>dD :<C-U>CocCommand explorer --preset right<CR>
nnoremap <silent> <Leader>dt :<C-U>CocCommand explorer --preset tab<CR>
nnoremap <silent> <Leader>df :<C-U>CocCommand explorer --preset floating<CR>
