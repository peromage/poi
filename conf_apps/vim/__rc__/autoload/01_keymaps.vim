""
"" Created by peromage on 2020/06/04
""
"" Customized keymaps
""

" My leader key
let mapleader=" "

" Splittin/
nnoremap <silent> <leader><Bar> :vs<CR>
nnoremap <silent> <leader><Bslash> :sp<CR>

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

" Tabs
nnoremap <silent> <leader>, gT
nnoremap <silent> <leader>. gt
nnoremap <silent> <leader>B :tabs<CR>:tabn<Space>
nnoremap <silent> <leader>t :tabnew<CR>

" Buffers
nnoremap <silent> gb :bn<CR>
nnoremap <silent> gB :bp<CR>
nnoremap <silent> <leader>/ :bn<CR>
nnoremap <silent> <leader>' :bp<CR>
nnoremap <silent> <leader>b :buffers<CR>:buffer<Space>
nnoremap <silent> <leader>n :enew<CR>

" Registers
nnoremap <silent> <leader>" :reg<CR>

" Quick quit
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>Q :qa<CR>
nnoremap <silent> <leader>x :bd<CR>
nnoremap <silent> <leader>X :%bd\|e#<CR>

" Turnoff hightlight
nnoremap <silent> <leader># :noh<CR>
nnoremap <silent> <leader>* :noh<CR>

" Show history messages
nnoremap <silent> <leader>: :messages<CR>

" Paste from system clipboard
nnoremap <silent> <leader>p "*p
vnoremap <silent> <leader>p "*p

" Copy to system clipboard
nnoremap <silent> <leader>y "*y
vnoremap <silent> <leader>y "*y

" Terminal
"tnoremap <Esc> <C-\><C-n>
