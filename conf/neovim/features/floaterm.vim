" Fzf settings
" Modified by peromage on 2021/02/01

if exists('g:loaded_rice_floaterm')
    finish
endif
let g:loaded_rice_floaterm = 1
Plug 'voldikss/vim-floaterm'

let g:floaterm_wintype = 'float'
let g:floaterm_position = 'topright'
let g:floaterm_title = ' term $1/$2 '
let g:floaterm_height = 0.5
let g:floaterm_width = 0.5

" Key bindings in normal mode
nnoremap <silent> <Esc><Esc>t :FloatermToggle<CR>
nnoremap <silent> <Esc><Esc>, :FloatermPrev<CR>
nnoremap <silent> <Esc><Esc>. :FloatermNext<CR>
nnoremap <silent> <Esc><Esc>n :FloatermNew<CR>
" Send a custom command
nnoremap <Esc><Esc>s :FloatermSend<Space>
" Execute current file
nnoremap <Esc><Esc>S :FloatermSend '%:p'<CR>

" Key bindings in terminal mode
tnoremap <silent> <Esc><Esc>t <C-\><C-n>:FloatermToggle<CR>
tnoremap <silent> <Esc><Esc>, <C-\><C-n>:FloatermPrev<CR>
tnoremap <silent> <Esc><Esc>. <C-\><C-n>:FloatermNext<CR>
tnoremap <silent> <Esc><Esc>n <C-\><C-n>:FloatermNew<CR>
