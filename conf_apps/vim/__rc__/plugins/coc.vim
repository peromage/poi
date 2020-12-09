""
"" Created by peromage on 2020/06/04
""
"" Coc settings
""

Plug 'neoclide/coc.nvim', {'branch': 'release'}


" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


"""" Keymaps
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[` and `]` to navigate diagnostics
nmap <silent> <leader>c[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>c] <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cy <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>ca <Plug>(coc-codeaction)
nmap <silent> <leader>cp :CocCommand<CR>
nmap <silent> <leader>cl :CocList<CR>

" Use k to show documentation in preview window.
nnoremap <silent> <leader>ck :call <SID>show_documentation()<CR>

" Show diagnostics messages
nnoremap <silent> <leader>cm :CocList diagnostics<CR>

" Symbol renaming.
nmap <leader>crn <Plug>(coc-rename)

" Formatting selected code
nmap <leader>cfm <Plug>(coc-format-selected)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
"nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)


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


"""" Coc plugins
" Override g:RC_Coc_Extensions to get change default extensions
if exists("g:RC_Coc_Extensions")
    let g:coc_global_extensions = g:RC_Coc_Extensions
endif


"""" Coc plugin keymaps
" File explorer
nnoremap <silent> <leader>e
    \ :CocCommand explorer
    \ --position left
    \ --sources buffer+,file+<CR>
    \ --toggle
