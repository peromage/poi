""" init-keybindings.vim -- Keybindings for vanilla Vim

"-------------------------------------------------------------------------------
" Nomal: Splitting
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(poi_vsplit) <C-w>v
nnoremap <silent> <Plug>(poi_hsplit) <C-w>s

"-------------------------------------------------------------------------------
" Normal: Pane jump
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(poi_pane_jump_left) <C-w>h
nnoremap <silent> <Plug>(poi_pane_jump_down) <C-w>j
nnoremap <silent> <Plug>(poi_pane_jump_up) <C-w>k
nnoremap <silent> <Plug>(poi_pane_jump_right) <C-w>l
nnoremap <silent> <Plug>(poi_pane_jump_previous) <C-w>p

"-------------------------------------------------------------------------------
" Normal: Pane size adjustment
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(poi_pane_vdecrease) <C-w>-
nnoremap <silent> <Plug>(poi_pane_vincrease) <C-w>+
nnoremap <silent> <Plug>(poi_pane_hdecrease) <C-w><
nnoremap <silent> <Plug>(poi_pane_hincrease) <C-w>>
nnoremap <silent> <Plug>(poi_pane_maximize) <C-w>o

"-------------------------------------------------------------------------------
" Normal: Tabs
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(poi_tab_previous) :<C-u>tabprevious<CR>
nnoremap <silent> <Plug>(poi_tab_next) :<C-u>tabnext<CR>
nnoremap <Plug>(poi_tab_jump) :<C-u>tabs<CR>:tabnext<Space>
nnoremap <silent> <Plug>(poi_tab_new) :<C-u>tabnew<CR>
nnoremap <silent> <Plug>(poi_tab_move_forward) :<C-u>tabmove +<CR>
nnoremap <silent> <Plug>(poi_tab_move_backward) :<C-u>tabmove -<CR>
nnoremap <silent> <Plug>(poi_tab_break) <C-w>T

"-------------------------------------------------------------------------------
" Normal: Buffers
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(poi_buffer_next) :<C-u>bn<CR>
nnoremap <silent> <Plug>(poi_buffer_previous) :<C-u>bp<CR>
nnoremap <Plug>(poi_buffer_jump) :<C-u>buffers<CR>:buffer<Space>
nnoremap <silent> <Plug>(poi_buffer_new) :<C-u>enew<CR>
nnoremap <silent> <Plug>(poi_buffer_close) <C-u>:bd<CR>
nnoremap <silent> <Plug>(poi_buffer_close_other) :<C-u>%bd\|e#<CR>

"-------------------------------------------------------------------------------
" Normal: Search and substitution
"-------------------------------------------------------------------------------
nnoremap <Plug>(poi_substitute_all) :<C-u>%s//gc<Left><Left><Left>
nnoremap <expr> <Plug>(poi_substitute_all_highlighted) ':<C-u>%s/' . @/ . '//gc<Left><Left><Left>'
nnoremap <silent> <Plug>(poi_search_off) :<C-u>noh<CR>
nnoremap <silent> <Plug>(poi_search_cword) *N

"-------------------------------------------------------------------------------
" Normal: Misc
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(poi_quit) :<C-u>q<CR>
nnoremap <silent> <Plug>(poi_quit_all) :<C-u>qa<CR>
nnoremap <silent> <Plug>(poi_save) :<C-u>w<CR>
nnoremap <silent> <Plug>(poi_save_all) :<C-u>wa<CR>
nnoremap <silent> <Plug>(poi_register) :<C-u>reg<CR>
nnoremap <silent> <Plug>(poi_message) :<C-u>messages<CR>
nnoremap <Plug>(poi_set_filetype) :<C-u>set filetype=
nnoremap <silent> <Plug>(poi_toggle_line_wrap) :<C-u>set wrap!<CR>

"-------------------------------------------------------------------------------
" Normal: Copy and paste
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(poi_toggle_paste_mode) :<C-u>set paste!<CR>
nnoremap <silent> <Plug>(poi_clipboard_copy) "*yy
nnoremap <silent> <Plug>(poi_clipboard_paste) :<C-u>set paste<CR>"*p:set nopaste<CR>

"-------------------------------------------------------------------------------
" Visual: Search
"-------------------------------------------------------------------------------
vnoremap <silent> <Plug>(poi_search_selected) y/\V<C-r>=escape(@",'/\')<CR><CR>N

"-------------------------------------------------------------------------------
" Visual: Copy and paste
"-------------------------------------------------------------------------------
vnoremap <silent> <Plug>(poi_clipboard_copy) "*y
vnoremap <silent> <Plug>(poi_clipboard_paste) :<C-u>set paste<CR>gv"*p:set nopaste<CR>

"-------------------------------------------------------------------------------
" Insert: cursor movement
"-------------------------------------------------------------------------------
inoremap <silent> <Plug>(poi_cursor_move_left) <left>
inoremap <silent> <Plug>(poi_cursor_move_down) <down>
inoremap <silent> <Plug>(poi_cursor_move_up) <up>
inoremap <silent> <Plug>(poi_cursor_move_right) <right>
inoremap <silent> <Plug>(poi_cursor_move_begin) <Home>
inoremap <silent> <Plug>(poi_cursor_move_end) <End>

"-------------------------------------------------------------------------------
" Insert: Copy and paste
"-------------------------------------------------------------------------------
inoremap <silent> <Plug>(poi_clipboard_copy) <C-o>"*yy
inoremap <silent> <Plug>(poi_clipboard_paste) <C-o>:<C-u>set paste<CR><C-r>*<C-o>:set nopaste<CR>

"-------------------------------------------------------------------------------
" Terminal: Terminal related
"-------------------------------------------------------------------------------
tnoremap <Plug>(poi_terminal_escape) <C-\><C-n>


"-------------------------------------------------------------------------------
" Bindings
"-------------------------------------------------------------------------------
" My leader key
let g:mapleader="\<Space>"

" The preset keymaps should be minimal
" With leader key
"
" <h> <j> <k> <l>
nmap <Leader>h <Plug>(poi_pane_jump_left)
nmap <Leader>j <Plug>(poi_pane_jump_down)
nmap <Leader>k <Plug>(poi_pane_jump_up)
nmap <Leader>l <Plug>(poi_pane_jump_right)

" <o>
nmap <Leader>o <Plug>(poi_pane_jump_previous)
nmap <Leader>O <Plug>(poi_pane_maximize)

" <Left> <Right> <Up> <Down> Pane
nmap <Down> <Plug>(poi_pane_vdecrease)
nmap <Up> <Plug>(poi_pane_vincrease)
nmap <Left> <Plug>(poi_pane_hdecrease)
nmap <Right> <Plug>(poi_pane_hincrease)

" <v>
nmap <Leader>v <Plug>(poi_vsplit)
nmap <Leader>s <Plug>(poi_hsplit)

" <n> Tab switching
nmap <Leader>f <Plug>(poi_tab_next)
nmap <Leader>b <Plug>(poi_tab_previous)

" <b> Buffer switching
nmap <Leader>n <Plug>(poi_buffer_next)
nmap <Leader>p <Plug>(poi_buffer_previous)

" <m> Tab movement
nmap <Leader>> <Plug>(poi_tab_move_forward)
nmap <Leader>< <Plug>(poi_tab_move_backward)

" <t> Tab creation
nmap <Leader>t <Plug>(poi_tab_new)
nmap <Leader>T <Plug>(poi_buffer_new)

" <x> Buffer closing
nmap <Leader>x <Plug>(poi_buffer_close)
nmap <Leader>X <Plug>(poi_buffer_close_other)

" <q> Buffer quiting
nmap <Leader>q <Plug>(poi_quit)
nmap <Leader>Q <Plug>(poi_quit_all)

" <w> Saving
nmap <Leader>w <Plug>(poi_save)
nmap <Leader>W <Plug>(poi_save_all)

" <*> <#> Hightlighting
nmap # <Plug>(poi_search_off)
nmap * <Plug>(poi_search_cword)
vmap * <Plug>(poi_search_selected)

" <g> Go to list
nmap <Leader>gt <Plug>(poi_tab_jump)
nmap <Leader>gb <Plug>(poi_buffer_jump)
nmap <Leader>g: <Plug>(poi_message)
nmap <Leader>g" <Plug>(poi_register)

" <u> System
nmap <Leader>up <Plug>(poi_clipboard_paste)
nmap <Leader>uy <Plug>(poi_clipboard_copy)
vmap <Leader>up <Plug>(poi_clipboard_paste)
vmap <Leader>uy <Plug>(poi_clipboard_copy)

" <c> Input commands
nmap <Leader>cf <Plug>(poi_set_filetype)
nmap <Leader>cs <Plug>(poi_substitute_all_highlighted)
nmap <Leader>cS <Plug>(poi_substitute_all)

" <i> Toggles
nmap <Leader>ip <Plug>(poi_toggle_paste_mode)
nmap <Leader>iw <Plug>(poi_toggle_line_wrap)

" <Esc>
tmap <Esc><Esc> <Plug>(poi_terminal_escape)

" With combination keys
"
" <C-h> <C-j> <C-k> <C-l> <C-a> <C-e>
imap <C-h> <Plug>(poi_cursor_move_left)
imap <C-j> <Plug>(poi_cursor_move_down)
imap <C-k> <Plug>(poi_cursor_move_up)
imap <C-l> <Plug>(poi_cursor_move_right)
imap <C-a> <Plug>(poi_cursor_move_begin)
imap <C-e> <Plug>(poi_cursor_move_end)
