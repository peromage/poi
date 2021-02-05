" Rice keymaps
" Modified by peromage on 2021/01/23

function! rice#mappings#init() abort
    " My leader key
    let g:mapleader="\<Space>"
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
    nnoremap <silent> <leader>H gT
    nnoremap <silent> <leader>L gt
    nnoremap <silent> <leader>bt :tabs<CR>:tabn<Space>
    nnoremap <silent> <leader>n :tabnew<CR>
    " Buffers
    nnoremap <silent> <leader>J :bn<CR>
    nnoremap <silent> <leader>K :bp<CR>
    nnoremap <silent> <leader>bb :buffers<CR>:buffer<Space>
    nnoremap <silent> <leader>N :enew<CR>
    " Registers
    nnoremap <silent> <leader>b" :reg<CR>
    " Quick quit
    nnoremap <silent> <leader>q :q<CR>
    nnoremap <silent> <leader>Q :qa<CR>
    nnoremap <silent> <leader>x :bd<CR>
    nnoremap <silent> <leader>X :%bd\|e#<CR>
    " Turnoff hightlight
    nnoremap <silent> <leader># :noh<CR>
    nnoremap <silent> <leader>* :noh<CR>
    " Show history messages
    nnoremap <silent> <leader>b: :messages<CR>
    " Paste from system clipboard
    nnoremap <silent> <leader>gp "*p
    vnoremap <silent> <leader>gp "*p
    " Copy to system clipboard
    nnoremap <silent> <leader>gy "*y
    vnoremap <silent> <leader>gy "*y
    " Terminal
    tnoremap <Esc><Esc> <C-\><C-n>
endfunction
