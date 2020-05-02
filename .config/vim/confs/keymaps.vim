" My leader key
let mapleader="\\"

" Splittin/
nnoremap <silent> <leader><Bslash> :vs<CR>
nnoremap <silent> <leader><Bar> :sp<CR>

" Pane movement
nnoremap <silent> <leader>h <C-w>h
nnoremap <silent> <leader>j <C-w>j
nnoremap <silent> <leader>k <C-w>k
nnoremap <silent> <leader>l <C-w>l

" Pane size adjustment
nnoremap <silent> _ <C-w>-
nnoremap <silent> + <C-w>+
nnoremap <silent> - <C-w><
nnoremap <silent> = <C-w>>
nnoremap <silent> <leader>W <C-w>_
nnoremap <silent> <leader>w <C-w>=

" Tabs
nnoremap <silent> <leader>- gT
nnoremap <silent> <leader>= gt
nnoremap <silent> <leader>t :tabnew<CR>
nnoremap <silent> <leader>T <C-w>T
nnoremap <silent> <leader>B :tabs<CR>

" Buffers
nnoremap <silent> <leader>] :bn<CR>
nnoremap <silent> <leader>[ :bp<CR>
nnoremap <silent> <leader>b :ls<CR>

" Registers
nnoremap <silent> <leader>r :reg<CR>

" Quick quit
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>Q :qa<CR>
nnoremap <silent> <leader>x :bd<CR>
nnoremap <silent> <leader>X :%bd\|e#<CR>

" Turnoff hightlight
nnoremap <silent> <leader># :noh<CR>
