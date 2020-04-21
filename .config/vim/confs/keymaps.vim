" Splitting
nnoremap <silent><leader><bslash> :vs<CR>
nnoremap <silent><leader><bar> :sp<CR>

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
nnoremap <silent><leader>w <C-w>_
nnoremap <silent><leader>W <C-w>=

" Tabs
nnoremap <silent><Left> gT
nnoremap <silent><Right> gt
nnoremap <silent><leader>t :tabnew<CR>
nnoremap <silent><leader>T <C-w>T

" Buffers
nnoremap <silent><Down> :bn<CR>
nnoremap <silent><Up> :bp<CR>
nnoremap <silent><leader>b :ls<CR>

" Registers
nnoremap <silent><leader>r :reg<CR>

" Quick quit
nnoremap <silent><leader>q :q<CR>
nnoremap <silent><leader>Q :qa<CR>
