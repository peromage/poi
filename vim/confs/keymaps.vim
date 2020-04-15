" Splitting
nnoremap <leader><bslash> :vs<CR>
nnoremap <leader><bar> :sp<CR>

" Pane movement
nnoremap <silent><C-h> <C-w>h
nnoremap <silent><C-j> <C-w>j
nnoremap <silent><C-k> <C-w>k
nnoremap <silent><C-l> <C-w>l

" Pane size adjustment
nnoremap <silent>_ <C-w>-
nnoremap <silent>+ <C-w>+
nnoremap <silent>- <C-w><
nnoremap <silent>= <C-w>>
nnoremap <leader>w <C-w>_
nnoremap <leader>W <C-w>=

" Tabs
nnoremap <silent><Left> gT
nnoremap <silent><Right> gt
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>T <C-w>T

" Buffers
nnoremap <silent><Down> :bn<CR>
nnoremap <silent><Up> :bp<CR>
nnoremap <leader>b :ls<CR>

" Quick quit
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa<CR>

