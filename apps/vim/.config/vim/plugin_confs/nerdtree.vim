" Default view
let g:NERDTreeShowHidden = 1

" Global keymaps
nnoremap <silent> <leader>e :NERDTree<CR>

" Keymaps when nerdtree is open
function! s:my_nerdtree_keymaps() abort
    setl nospell
    setl signcolumn=no
    setl nonumber
    setl norelativenumber
    setl cursorline
    setl cursorcolumn
endfunction

autocmd FileType nerdtree call s:my_nerdtree_keymaps()
