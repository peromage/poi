" Coc plugin settings
" Modified by peromage on 2021/02/04

if !exists('g:did_coc_loaded') || !g:did_coc_loaded
    finish
endif
if exists('g:loaded_rice_coc_plugins')
    finish
endif
let g:loaded_rice_coc_plugins = 1

" File explorer
let g:coc_explorer_global_presets = {
\   'left' : {
\       'toggle': v:true,
\       'focus': v:true,
\       'open-action-strategy': 'select',
\       'quit-on-open': v:false,
\       'sources': [
\           { 'name': 'buffer', 'expand': v:true },
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
\           { 'name': 'buffer', 'expand': v:true },
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
\           { 'name': 'buffer', 'expand': v:true },
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
\           { 'name': 'buffer', 'expand': v:true },
\           { 'name': 'file', 'expand': v:true }
\       ],
\       'position': 'tab',
\       'content-width-type': 'vim-width'
\   }
\ }
nnoremap <silent> <leader><leader>ee :CocCommand explorer --preset left<CR>
nnoremap <silent> <leader><leader>eE :CocCommand explorer --preset right<CR>
nnoremap <silent> <leader><leader>et :CocCommand explorer --preset tab<CR>
nnoremap <silent> <leader><leader>ef :CocCommand explorer --preset floating<CR>
