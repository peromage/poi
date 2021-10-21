""" gui-init-config.vim -- GUI specific settings

""------------------------------------------------------------------------------
"" Appearance
""------------------------------------------------------------------------------

set guioptions=egmrLtT

""------------------------------------------------------------------------------
"" Keymaps
""------------------------------------------------------------------------------

vnoremap <silent> <C-S-c> "*y
vnoremap <silent> <C-S-v> :<C-u>set paste<CR>gv"*p:set nopaste<CR>
inoremap <silent> <C-S-c> <C-o>"*yy
inoremap <silent> <C-S-v> <C-o>:<C-u>set paste<CR><C-r>*<C-o>:set nopaste<CR>
