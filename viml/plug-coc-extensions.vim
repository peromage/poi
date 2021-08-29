""" plug-coc-extensions.vim -- Coc extensions

" Default Coc directory
let g:coc_data_home = simplify(poi#home . '/coc-extensions')
let g:coc_config_home = poi#home

" Default Coc extensions
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

" File explorer
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
