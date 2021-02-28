""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Customized keymaps
"
" Created by peromage 2021/02/23
" Last modified 2021/02/23
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" Splitting
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_vsplit) :vs<CR>
nnoremap <silent> <Plug>(rice_hsplit) :sp<CR>

"-------------------------------------------------------------------------------
" Pane jump
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_pane_jump_left) <C-w>h
nnoremap <silent> <Plug>(rice_pane_jump_down) <C-w>j
nnoremap <silent> <Plug>(rice_pane_jump_up) <C-w>k
nnoremap <silent> <Plug>(rice_pane_jump_right) <C-w>l
nnoremap <silent> <Plug>(rice_pane_jump_previous) <C-w>p

"-------------------------------------------------------------------------------
" Pane size adjustment
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_pane_vdecrease) <C-w>-
nnoremap <silent> <Plug>(rice_pane_vincrease) <C-w>+
nnoremap <silent> <Plug>(rice_pane_hdecrease) <C-w><
nnoremap <silent> <Plug>(rice_pane_hincrease) <C-w>>
nnoremap <silent> <Plug>(rice_pane_maximize) <C-w>o

"-------------------------------------------------------------------------------
" Tabs
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_tab_previous) :tabprevious<CR>
nnoremap <silent> <Plug>(rice_tab_next) :tabnext<CR>
nnoremap <Plug>(rice_tab_jump) :tabs<CR>:tabnext<Space>
nnoremap <silent> <Plug>(rice_tab_new) :tabnew<CR>
nnoremap <silent> <Plug>(rice_tab_move_forward) :tabmove +<CR>
nnoremap <silent> <Plug>(rice_tab_move_backward) :tabmove -<CR>

"-------------------------------------------------------------------------------
" Buffers
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_buffer_next) :bn<CR>
nnoremap <silent> <Plug>(rice_buffer_previous) :bp<CR>
nnoremap <Plug>(rice_buffer_jump) :buffers<CR>:buffer<Space>
nnoremap <silent> <Plug>(rice_buffer_new) :enew<CR>
nnoremap <silent> <Plug>(rice_buffer_close) :bd<CR>
nnoremap <silent> <Plug>(rice_buffer_close_other) :%bd\|e#<CR>

"-------------------------------------------------------------------------------
" Search and substitution
"-------------------------------------------------------------------------------
nnoremap <Plug>(rice_substitute_all) :%s//gc<Left><Left><Left>
nnoremap <expr> <Plug>(rice_substitute_all_highlighted) ':%s/' . @/ . '//gc<Left><Left><Left>'
nnoremap <silent> <Plug>(rice_search_off) :noh<CR>
nnoremap <silent> <Plug>(rice_search_cword) *N

"-------------------------------------------------------------------------------
" Misc
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_quit) :q<CR>
nnoremap <silent> <Plug>(rice_quit_all) :qa<CR>
nnoremap <silent> <Plug>(rice_save) :w<CR>
nnoremap <silent> <Plug>(rice_save_all) :wa<CR>
nnoremap <silent> <Plug>(rice_register) :reg<CR>
nnoremap <silent> <Plug>(rice_message) :messages<CR>
nnoremap <Plug>(rice_set_filetype) :set filetype=

"-------------------------------------------------------------------------------
" GUI clipboard
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_clipboard_paste) "*p
nnoremap <silent> <Plug>(rice_clipboard_copy) "*y

"-------------------------------------------------------------------------------
" Visual mode: GUI clipboard
"-------------------------------------------------------------------------------
vnoremap <silent> <Plug>(rice_clipboard_paste) "*p
vnoremap <silent> <Plug>(rice_clipboard_copy) "*y

"-------------------------------------------------------------------------------
" Visual mode: Search
"-------------------------------------------------------------------------------
vnoremap <silent> <Plug>(rice_search_selected) y/\V<C-R>=escape(@",'/\')<CR><CR>N

"-------------------------------------------------------------------------------
" Insert mode: cursor movement
"-------------------------------------------------------------------------------
inoremap <silent> <Plug>(rice_cursor_move_left) <left>
inoremap <silent> <Plug>(rice_cursor_move_down) <down>
inoremap <silent> <Plug>(rice_cursor_move_up) <up>
inoremap <silent> <Plug>(rice_cursor_move_right) <right>

"-------------------------------------------------------------------------------
" Terminal mode
"-------------------------------------------------------------------------------
tnoremap <Plug>(rice_terminal_escape) <C-\><C-n>


"-------------------------------------------------------------------------------
" Bindings
"-------------------------------------------------------------------------------
" My leader key
let g:mapleader="\<Space>"

" The preset keymaps should be minimal

" Normal mode
" <h> <j> <k> <l>
nmap <leader>h <Plug>(rice_pane_jump_left)
nmap <leader>j <Plug>(rice_pane_jump_down)
nmap <leader>k <Plug>(rice_pane_jump_up)
nmap <leader>l <Plug>(rice_pane_jump_right)

" <p>
nmap <leader>p <Plug>(rice_pane_jump_previous)

" <o>
nmap <leader>o <Plug>(rice_pane_maximize)

" <bslash>
nmap <leader><Bar> <Plug>(rice_vsplit)
nmap <leader><Bslash> <Plug>(rice_hsplit)

" <minus>/<plus>
nmap _ <Plug>(rice_pane_vdecrease)
nmap + <Plug>(rice_pane_vincrease)
nmap - <Plug>(rice_pane_hdecrease)
nmap = <Plug>(rice_pane_hincrease)

" <n> Tab switching
nmap <leader>n <Plug>(rice_tab_next)
nmap <leader>N <Plug>(rice_tab_previous)

" <b> Buffer switching
nmap <leader>b <Plug>(rice_buffer_next)
nmap <leader>B <Plug>(rice_buffer_previous)

" <m> Tab movement
nmap <leader>m <Plug>(rice_tab_move_forward)
nmap <leader>M <Plug>(rice_tab_move_backward)

" <g> Go to list
nmap <leader>gt <Plug>(rice_tab_jump)
nmap <leader>gb <Plug>(rice_buffer_jump)
nmap <leader>g: <Plug>(rice_message)
nmap <leader>g" <Plug>(rice_register)

" <t> Tab creation
nmap <leader>t <Plug>(rice_tab_new)
nmap <leader>T <Plug>(rice_buffer_new)

" <x> Buffer closing
nmap <leader>x <Plug>(rice_buffer_close)
nmap <leader>X <Plug>(rice_buffer_close_other)

" <q> Buffer quiting
nmap <leader>q <Plug>(rice_quit)
nmap <leader>Q <Plug>(rice_quit_all)

" <w> Saving
nmap <leader>w <Plug>(rice_save)
nmap <leader>W <Plug>(rice_save_all)

" <*> <#> Hightlighting
nmap # <Plug>(rice_search_off)
nmap * <Plug>(rice_search_cword)

" <u> GUI
nmap <leader>up <Plug>(rice_clipboard_paste)
nmap <leader>uy <Plug>(rice_clipboard_copy)

" <i> Commands
nmap <leader>if <Plug>(rice_set_filetype)
nmap <leader>is <Plug>(rice_substitute_all)
nmap <leader>iS <Plug>(rice_substitute_all_highlighted)

" Visual mode
vmap <leader>up <Plug>(rice_clipboard_paste)
vmap <leader>uy <Plug>(rice_clipboard_copy)
vmap * <Plug>(rice_search_selected)

" Terminal mode
tmap <Esc><Esc> <Plug>(rice_terminal_escape)

" Insert mode
imap <C-h> <Plug>(rice_cursor_move_left)
imap <C-j> <Plug>(rice_cursor_move_down)
imap <C-k> <Plug>(rice_cursor_move_up)
imap <C-l> <Plug>(rice_cursor_move_right)
imap <C-a> <Home>
imap <C-e> <End>
