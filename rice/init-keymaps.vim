""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Customized keymaps
"
" Created by peromage 2021/02/23
" Last modified 2021/02/23
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
nnoremap <silent> <Plug>(rice_tab_previous) :tabprevious<CR>
nnoremap <silent> <Plug>(rice_tab_next) :tabnext<CR>
nnoremap <Plug>(rice_tab_jump) :tabs<CR>:tabnext<Space>
nnoremap <silent> <Plug>(rice_tab_new) :tabnew<CR>
nnoremap <silent> <Plug>(rice_tab_move_forward) :tabmove +<CR>
nnoremap <silent> <Plug>(rice_tab_move_backward) :tabmove -<CR>

"-------------------------------------------------------------------------------
" Normal: Buffers
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_buffer_next) :bn<CR>
nnoremap <silent> <Plug>(rice_buffer_previous) :bp<CR>
nnoremap <Plug>(rice_buffer_jump) :buffers<CR>:buffer<Space>
nnoremap <silent> <Plug>(rice_buffer_new) :enew<CR>
nnoremap <silent> <Plug>(rice_buffer_close) :bd<CR>
nnoremap <silent> <Plug>(rice_buffer_close_other) :%bd\|e#<CR>

"-------------------------------------------------------------------------------
" Normal: Search and substitution
"-------------------------------------------------------------------------------
nnoremap <Plug>(rice_substitute_all) :%s//gc<Left><Left><Left>
nnoremap <expr> <Plug>(rice_substitute_all_highlighted) ':%s/' . @/ . '//gc<Left><Left><Left>'
nnoremap <silent> <Plug>(rice_search_off) :noh<CR>
nnoremap <silent> <Plug>(rice_search_cword) *N

"-------------------------------------------------------------------------------
" Normal: Misc
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_quit) :q<CR>
nnoremap <silent> <Plug>(rice_quit_all) :qa<CR>
nnoremap <silent> <Plug>(rice_save) :w<CR>
nnoremap <silent> <Plug>(rice_save_all) :wa<CR>
nnoremap <silent> <Plug>(rice_register) :reg<CR>
nnoremap <silent> <Plug>(rice_message) :messages<CR>
nnoremap <Plug>(rice_set_filetype) :set filetype=
nnoremap <silent> <Plug>(rice_toggle_line_wrap) :set wrap!<CR>

"-------------------------------------------------------------------------------
" Normal: Copy and paste
"-------------------------------------------------------------------------------
nnoremap <silent> <Plug>(rice_toggle_paste_mode) :set paste!<CR>
nnoremap <silent> <Plug>(rice_clipboard_copy) "*yy
nnoremap <silent> <Plug>(rice_clipboard_paste) :set paste<CR>"*p:set nopaste<CR>

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

"-------------------------------------------------------------------------------
" Insert: Copy and paste
"-------------------------------------------------------------------------------
inoremap <silent> <Plug>(rice_clipboard_copy) <C-O>"*yy
inoremap <silent> <Plug>(rice_clipboard_paste) <C-O>:set paste<CR><C-R>*<C-O>:set nopaste<CR>

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
nmap <leader>h <Plug>(rice_pane_jump_left)
nmap <leader>j <Plug>(rice_pane_jump_down)
nmap <leader>k <Plug>(rice_pane_jump_up)
nmap <leader>l <Plug>(rice_pane_jump_right)

" <p>
nmap <leader>p <Plug>(rice_toggle_paste_mode)
nmap <leader>P <Plug>(rice_toggle_line_wrap)

" <o>
nmap <leader>o <Plug>(rice_pane_jump_previous)
nmap <leader>O <Plug>(rice_pane_maximize)

" <Left> <Right> <Up> <Down> Pane
nmap <Down> <Plug>(rice_pane_vdecrease)
nmap <Up> <Plug>(rice_pane_vincrease)
nmap <Left> <Plug>(rice_pane_hdecrease)
nmap <Right> <Plug>(rice_pane_hincrease)

" <v>
nmap <leader>v <Plug>(rice_vsplit)
nmap <leader>V <Plug>(rice_hsplit)

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
vmap * <Plug>(rice_search_selected)

" <u> System
nmap <leader>up <Plug>(rice_clipboard_paste)
nmap <leader>uy <Plug>(rice_clipboard_copy)
vmap <leader>up <Plug>(rice_clipboard_paste)
vmap <leader>uy <Plug>(rice_clipboard_copy)

" <i> Input commands
nmap <leader>if <Plug>(rice_set_filetype)
nmap <leader>is <Plug>(rice_substitute_all)
nmap <leader>iS <Plug>(rice_substitute_all_highlighted)

" <Esc>
tmap <Esc><Esc> <Plug>(rice_terminal_escape)

" With combination keys
"
" <C-H> <C-J> <C-K> <C-L> <C-A> <C-E>
imap <C-H> <Plug>(rice_cursor_move_left)
imap <C-J> <Plug>(rice_cursor_move_down)
imap <C-K> <Plug>(rice_cursor_move_up)
imap <C-L> <Plug>(rice_cursor_move_right)
imap <C-A> <Home>
imap <C-E> <End>
