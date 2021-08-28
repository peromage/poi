""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Coc settings
"
" Created by peromage 2021/02/24
" Last modified 2021/03/19
"
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_rice_plug_coc = 1

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
nmap <silent> <C-l>d <Plug>(coc-definition)
nmap <silent> <C-l>t <Plug>(coc-type-definition)
nmap <silent> <C-l>i <Plug>(coc-implementation)
nmap <silent> <C-l>r <Plug>(coc-references)
nmap <silent> <C-l>a <Plug>(coc-codeaction)
nmap <silent> <C-l>c :<C-U>CocCommand<CR>
nmap <silent> <C-l>C :<C-U>CocList<CR>

" Use k to show documentation in preview window.
nnoremap <silent> <C-l>k :<C-U>call <SID>show_documentation()<CR>

" Show diagnostics messages
nnoremap <silent> <C-l>m :<C-U>CocList diagnostics<CR>
nmap <silent> <C-l>n <Plug>(coc-diagnostic-next)
nmap <silent> <C-l>p <Plug>(coc-diagnostic-prev)

" Other shortcuts
" Symbol renaming.
nmap <C-l>R <Plug>(coc-rename)
" Formatting selected code
nmap <C-l>F <Plug>(coc-format-selected)

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

nnoremap <silent> <Leader>dd :<C-U>CocCommand explorer --preset left<CR>
nnoremap <silent> <Leader>dD :<C-U>CocCommand explorer --preset right<CR>
nnoremap <silent> <Leader>dt :<C-U>CocCommand explorer --preset tab<CR>
nnoremap <silent> <Leader>df :<C-U>CocCommand explorer --preset floating<CR>
