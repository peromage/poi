""
"" Created by peromage on 2020/06/04
""
"" Settings for built-in netrw explorer
""

" Netrw general settings
let g:netrw_altfile = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_sizestyle = "H"
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_alto = 1
let g:netrw_winsize = 20
let g:netrw_cursor = 4
let g:netrw_fastbrowse = 1
let g:netrw_hide = 1
let g:netrw_keepdir = 1
let g:netrw_usetab = 0
let g:netrw_preview = 0

" Global Hotkey
nnoremap <silent> <leader>e :Lexplore<CR>

" Keymaps when Netrw is open
function! s:my_netrw_keymaps() abort
    setl nospell
    setl signcolumn=no
    setl nonumber
    setl norelativenumber
    setl cursorline
    setl cursorcolumn
endfunction

autocmd FileType netrw call s:my_netrw_keymaps()
