""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Floaterm settings
"
" Created by peromage 2021/02/24
" Last modified 2021/02/24
"
"Plug 'voldikss/vim-floaterm'
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_rice_bundle_floaterm = 1

let g:floaterm_wintype = 'float'
let g:floaterm_position = 'topright'
let g:floaterm_title = ' term $1/$2 '
let g:floaterm_height = 0.5
let g:floaterm_width = 0.5

" Key bindings in normal mode
nnoremap <silent> <Bslash>tt :FloatermToggle<CR>
" Send a custom command
nnoremap <Bslash>ts :FloatermSend<Space>
" Execute current file
nnoremap <Bslash>tS :FloatermSend %:p<CR><CR>
" Key bindings in terminal mode
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>
tnoremap <silent> <C-h> <C-\><C-n>:FloatermPrev<CR>
tnoremap <silent> <C-l> <C-\><C-n>:FloatermNext<CR>
tnoremap <silent> <C-n> <C-\><C-n>:FloatermNew<CR>
