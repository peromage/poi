" My leader key
let mapleader="\\"

" Splitting
nnoremap <silent><leader><bslash> :vs<CR>
nnoremap <silent><leader><bar> :sp<CR>

" Pane movement
nnoremap <silent><leader>h <C-w>h
nnoremap <silent><leader>j <C-w>j
nnoremap <silent><leader>k <C-w>k
nnoremap <silent><leader>l <C-w>l

" Pane size adjustment
nnoremap <silent>_ <C-w>-
nnoremap <silent>+ <C-w>+
nnoremap <silent>- <C-w><
nnoremap <silent>= <C-w>>
nnoremap <silent><leader>p <C-w>_
nnoremap <silent><leader>P <C-w>=

" Tabs
nnoremap <silent><leader>- gT
nnoremap <silent><leader>= gt
nnoremap <silent><leader>t :tabnew<CR>
nnoremap <silent><leader>T <C-w>T
nnoremap <silent><leader>B :tabs<CR>

" Buffers
nnoremap <silent><leader>] :bn<CR>
nnoremap <silent><leader>[ :bp<CR>
nnoremap <silent><leader>b :ls<CR>

" Registers
nnoremap <silent><leader>' :reg<CR>

" Quick quit
nnoremap <silent><leader>q :q<CR>
nnoremap <silent><leader>Q :qa<CR>

" Turnoff hightlight
nnoremap <silent><leader># :noh<CR>

