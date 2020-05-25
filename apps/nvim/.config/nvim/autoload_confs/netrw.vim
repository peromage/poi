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

" Keymaps when Netrw is open
function! s:my_netrw_keymaps() abort
    
endfunction

" Netrw bindings
nnoremap <silent> <leader>e :Lexplore<CR>
