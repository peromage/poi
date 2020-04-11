" Splitting
nnoremap <silent><C-;> :vs<CR>
nnoremap <silent><C-S-:> :sp<CR>

" Pane movement
nnoremap <silent><C-h> <C-w>h
nnoremap <silent><C-j> <C-w>j
nnoremap <silent><C-k> <C-w>k
nnoremap <silent><C-l> <C-w>l

" Pane size adjustment
nnoremap <silent><C--> <C-w>-
nnoremap <silent><C-S-_> <C-w>_
nnoremap <silent><C-=> <C-w>=
nnoremap <silent><C-S-+> <C-w>+
nnoremap <silent><C-S-<> <C-w><
nnoremap <silent><C-S->> <C-w>>

" Tabs
nnoremap <silent><C-S-H> gT
nnoremap <silent><C-S-L> gt
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>T <C-w>T

" Buffers
nnoremap <silent><C-S-J> :bn<CR>
nnoremap <silent><C-S-K> :bp<CR>
nnoremap <leader>b :ls<CR>

" Quick quit
nnoremap <silent><C-q> :q<CR>
