""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Coc settings
"
" Created by peromage 2021/02/24
" Last modified 2021/02/24
"
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_rice_bundle_coc = 1

" Default coc extensions
" To override the default define g:coc_global_extensions after sourcing this
" file
let s:default_extensions = [
\   'coc-explorer',
\   'coc-tabnine',
\   'coc-snippets',
\   'coc-git',
\   'coc-json',
\   'coc-markdownlint',
\   'coc-vimlsp'
\   ]

if exists('g:coc_global_extensions')
    call extend(g:coc_global_extensions, s:default_extensions)
else
    let g:coc_global_extensions = s:default_extensions
endif

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent! call CocActionAsync('highlight')

"""" Script defined functions
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

"""" Keymaps
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()['selected'] != '-1' ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>ct <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>ca <Plug>(coc-codeaction)
nmap <silent> <leader>cp :CocCommand<CR>
nmap <silent> <leader>cl :CocList<CR>

" Use k to show documentation in preview window.
nnoremap <silent> <leader>ck :call <SID>show_documentation()<CR>

" Show diagnostics messages
nnoremap <silent> <leader>cm :CocList diagnostics<CR>
nmap <silent> <leader>cn <Plug>(coc-diagnostic-next)
nmap <silent> <leader>cN <Plug>(coc-diagnostic-prev)

" Other shortcuts
" Symbol renaming.
nmap <leader>ccr <Plug>(coc-rename)
" Formatting selected code
nmap <leader>ccf <Plug>(coc-format-selected)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
"nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

"-------------------------------------------------------------------------------

" Extension configs
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

nnoremap <silent> <leader>ee :CocCommand explorer --preset left<CR>
nnoremap <silent> <leader>eE :CocCommand explorer --preset right<CR>
nnoremap <silent> <leader>en :CocCommand explorer --preset tab<CR>
nnoremap <silent> <leader>ef :CocCommand explorer --preset floating<CR>
