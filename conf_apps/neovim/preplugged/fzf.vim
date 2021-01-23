" Fzf settings
" Modified by peromage on 2021/01/22

if exists('g:loaded_rice_plugged_fzf')
    finish
endif
let g:loaded_rice_plugged_fzf = 1
Plug 'junegunn/fzf.vim'


nnoremap <silent> <C-p> :Files<CR>
