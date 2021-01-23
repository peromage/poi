" NerdTree settings
" Modified by peromage on 2021/01/22

if exists('g:loaded_rice_nerdtree')
    finish
endif
let g:loaded_rice_nerdtree = 1
Plug 'preservim/nerdtree'


" Default view
let g:NERDTreeShowHidden = 1

" Global keymaps
nnoremap <silent> <leader>e :NERDTree<CR>

" Keymaps when nerdtree is open
function! s:myNerdtreeSettings() abort
    setl nospell
    setl signcolumn=no
    setl nonumber
    setl norelativenumber
    setl cursorline
    setl cursorcolumn
endfunction

autocmd FileType nerdtree call s:myNerdtreeSettings()
