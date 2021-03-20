""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Customized keymaps
"
" Created by peromage 2021/02/23
" Last modified 2021/03/19
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" Nomal: Splitting
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_vsplit) <C-W>v
nnoremap <silent> <Plug>(rice_hsplit) <C-W>s

"-------------------------------------------------------------------------------
" Normal: Pane jump
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_pane_jump_left) <C-W>h
nnoremap <silent> <Plug>(rice_pane_jump_down) <C-W>j
nnoremap <silent> <Plug>(rice_pane_jump_up) <C-W>k
nnoremap <silent> <Plug>(rice_pane_jump_right) <C-W>l
nnoremap <silent> <Plug>(rice_pane_jump_previous) <C-W>p

"-------------------------------------------------------------------------------
" Normal: Pane size adjustment
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_pane_vdecrease) <C-W>-
nnoremap <silent> <Plug>(rice_pane_vincrease) <C-W>+
nnoremap <silent> <Plug>(rice_pane_hdecrease) <C-W><
nnoremap <silent> <Plug>(rice_pane_hincrease) <C-W>>
nnoremap <silent> <Plug>(rice_pane_maximize) <C-W>o

"-------------------------------------------------------------------------------
" Normal: Tabs
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_tab_previous) :<C-U>tabprevious<CR>
nnoremap <silent> <Plug>(rice_tab_next) :<C-U>tabnext<CR>
nnoremap <Plug>(rice_tab_jump) :<C-U>tabs<CR>:tabnext<Space>
nnoremap <silent> <Plug>(rice_tab_new) :<C-U>tabnew<CR>
nnoremap <silent> <Plug>(rice_tab_move_forward) :<C-U>tabmove +<CR>
nnoremap <silent> <Plug>(rice_tab_move_backward) :<C-U>tabmove -<CR>

"-------------------------------------------------------------------------------
" Normal: Buffers
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_buffer_next) :<C-U>bn<CR>
nnoremap <silent> <Plug>(rice_buffer_previous) :<C-U>bp<CR>
nnoremap <Plug>(rice_buffer_jump) :<C-U>buffers<CR>:buffer<Space>
nnoremap <silent> <Plug>(rice_buffer_new) :<C-U>enew<CR>
nnoremap <silent> <Plug>(rice_buffer_close) <C-U>:bd<CR>
nnoremap <silent> <Plug>(rice_buffer_close_other) :<C-U>%bd\|e#<CR>

"-------------------------------------------------------------------------------
" Normal: Search and substitution
"-------------------------------------------------------------------------------
nnoremap <Plug>(rice_substitute_all) :<C-U>%s//gc<Left><Left><Left>
nnoremap <expr> <Plug>(rice_substitute_all_highlighted) ':<C-U>%s/' . @/ . '//gc<Left><Left><Left>'
nnoremap <silent> <Plug>(rice_search_off) :<C-U>noh<CR>
nnoremap <silent> <Plug>(rice_search_cword) *N

"-------------------------------------------------------------------------------
" Normal: Misc
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_quit) :<C-U>q<CR>
nnoremap <silent> <Plug>(rice_quit_all) :<C-U>qa<CR>
nnoremap <silent> <Plug>(rice_save) :<C-U>w<CR>
nnoremap <silent> <Plug>(rice_save_all) :<C-U>wa<CR>
nnoremap <silent> <Plug>(rice_register) :<C-U>reg<CR>
nnoremap <silent> <Plug>(rice_message) :<C-U>messages<CR>
nnoremap <Plug>(rice_set_filetype) :<C-U>set filetype=
nnoremap <silent> <Plug>(rice_toggle_line_wrap) :<C-U>set wrap!<CR>

"-------------------------------------------------------------------------------
" Normal: Copy and paste
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_toggle_paste_mode) :<C-U>set paste!<CR>
nnoremap <silent> <Plug>(rice_clipboard_copy) "*yy
nnoremap <silent> <Plug>(rice_clipboard_paste) :<C-U>set paste<CR>"*p:set nopaste<CR>

"-------------------------------------------------------------------------------
" Visual: Search
"-------------------------------------------------------------------------------
vnoremap <silent> <Plug>(rice_search_selected) y/\V<C-R>=escape(@",'/\')<CR><CR>N

"-------------------------------------------------------------------------------
" Visual: Copy and paste
"-------------------------------------------------------------------------------
vnoremap <silent> <Plug>(rice_clipboard_copy) "*y
vnoremap <silent> <Plug>(rice_clipboard_paste) :<C-U>set paste<CR>gv"*p:set nopaste<CR>

"-------------------------------------------------------------------------------
" Insert: cursor movement
"-------------------------------------------------------------------------------
inoremap <silent> <Plug>(rice_cursor_move_left) <left>
inoremap <silent> <Plug>(rice_cursor_move_down) <down>
inoremap <silent> <Plug>(rice_cursor_move_up) <up>
inoremap <silent> <Plug>(rice_cursor_move_right) <right>
inoremap <silent> <Plug>(rice_cursor_move_begin) <Home>
inoremap <silent> <Plug>(rice_cursor_move_end) <End>

"-------------------------------------------------------------------------------
" Insert: Copy and paste
"-------------------------------------------------------------------------------
inoremap <silent> <Plug>(rice_clipboard_copy) <C-O>"*yy
inoremap <silent> <Plug>(rice_clipboard_paste) <C-O>:<C-U>set paste<CR><C-R>*<C-O>:set nopaste<CR>

"-------------------------------------------------------------------------------
" Terminal: Terminal related
"-------------------------------------------------------------------------------
tnoremap <Plug>(rice_terminal_escape) <C-\><C-N>


"-------------------------------------------------------------------------------
" Bindings
"-------------------------------------------------------------------------------
" My leader key
let g:mapleader="\<Space>"

" The preset keymaps should be minimal
" With leader key
"
" <h> <j> <k> <l>
nmap <Leader>h <Plug>(rice_pane_jump_left)
nmap <Leader>j <Plug>(rice_pane_jump_down)
nmap <Leader>k <Plug>(rice_pane_jump_up)
nmap <Leader>l <Plug>(rice_pane_jump_right)

" <p>
nmap <Leader>p <Plug>(rice_toggle_paste_mode)
nmap <Leader>P <Plug>(rice_toggle_line_wrap)

" <o>
nmap <Leader>o <Plug>(rice_pane_jump_previous)
nmap <Leader>O <Plug>(rice_pane_maximize)

" <Left> <Right> <Up> <Down> Pane
nmap <Down> <Plug>(rice_pane_vdecrease)
nmap <Up> <Plug>(rice_pane_vincrease)
nmap <Left> <Plug>(rice_pane_hdecrease)
nmap <Right> <Plug>(rice_pane_hincrease)

" <v>
nmap <Leader>v <Plug>(rice_vsplit)
nmap <Leader>V <Plug>(rice_hsplit)

" <n> Tab switching
nmap <Leader>n <Plug>(rice_tab_next)
nmap <Leader>N <Plug>(rice_tab_previous)

" <b> Buffer switching
nmap <Leader>b <Plug>(rice_buffer_next)
nmap <Leader>B <Plug>(rice_buffer_previous)

" <m> Tab movement
nmap <Leader>m <Plug>(rice_tab_move_forward)
nmap <Leader>M <Plug>(rice_tab_move_backward)

" <g> Go to list
nmap <Leader>gt <Plug>(rice_tab_jump)
nmap <Leader>gb <Plug>(rice_buffer_jump)
nmap <Leader>g: <Plug>(rice_message)
nmap <Leader>g" <Plug>(rice_register)

" <t> Tab creation
nmap <Leader>t <Plug>(rice_tab_new)
nmap <Leader>T <Plug>(rice_buffer_new)

" <x> Buffer closing
nmap <Leader>x <Plug>(rice_buffer_close)
nmap <Leader>X <Plug>(rice_buffer_close_other)

" <q> Buffer quiting
nmap <Leader>q <Plug>(rice_quit)
nmap <Leader>Q <Plug>(rice_quit_all)

" <w> Saving
nmap <Leader>w <Plug>(rice_save)
nmap <Leader>W <Plug>(rice_save_all)

" <*> <#> Hightlighting
nmap # <Plug>(rice_search_off)
nmap * <Plug>(rice_search_cword)
vmap * <Plug>(rice_search_selected)

" <u> System
nmap <Leader>up <Plug>(rice_clipboard_paste)
nmap <Leader>uy <Plug>(rice_clipboard_copy)
vmap <Leader>up <Plug>(rice_clipboard_paste)
vmap <Leader>uy <Plug>(rice_clipboard_copy)

" <i> Input commands
nmap <Leader>if <Plug>(rice_set_filetype)
nmap <Leader>is <Plug>(rice_substitute_all)
nmap <Leader>iS <Plug>(rice_substitute_all_highlighted)

" <Esc>
tmap <Esc><Esc> <Plug>(rice_terminal_escape)

" With combination keys
"
" <C-H> <C-J> <C-K> <C-L> <C-A> <C-E>
imap <C-H> <Plug>(rice_cursor_move_left)
imap <C-J> <Plug>(rice_cursor_move_down)
imap <C-K> <Plug>(rice_cursor_move_up)
imap <C-L> <Plug>(rice_cursor_move_right)
imap <C-A> <Plug>(rice_cursor_move_begin)
imap <C-E> <Plug>(rice_cursor_move_end)
