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
nnoremap <silent> <leader><leader>tt :FloatermToggle<CR>
" Send a custom command
nnoremap <leader><leader>ts :FloatermSend<Space>
" Execute current file
nnoremap <leader><leader>tS :FloatermSend %:p<CR><CR>
" Key bindings in terminal mode
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>
tnoremap <silent> <C-h> <C-\><C-n>:FloatermPrev<CR>
tnoremap <silent> <C-l> <C-\><C-n>:FloatermNext<CR>
tnoremap <silent> <C-n> <C-\><C-n>:FloatermNew<CR>
