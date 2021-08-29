""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Nerdtree settings
"
" Created by peromage 2021/02/24
" Last modified 2021/03/19
"
"Plug 'preservim/nerdtree'
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_poi_plug_navigation_nerdtree = 1

Plug 'preservim/nerdtree'

" Default view
let g:NERDTreeShowHidden = 1

" Global keymaps
nnoremap <silent> <Leader>d :<C-U>NERDTree<CR>

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
