""" init-keymap.vim -- Keymaps that respect the vanilla Vim features

""------------------------------------------------------------------------------
"" Leader key
""------------------------------------------------------------------------------

let g:mapleader="\<Space>"

""------------------------------------------------------------------------------
"" Normal: Pane
""------------------------------------------------------------------------------

"" Cursor movement
nnoremap <silent> <Leader>h <C-w>h
nnoremap <silent> <Leader>j <C-w>j
nnoremap <silent> <Leader>k <C-w>k
nnoremap <silent> <Leader>l <C-w>l
nnoremap <silent> <Leader>o <C-w>p

"" Splitting
nnoremap <silent> <Leader>v <C-w>v
nnoremap <silent> <Leader>s <C-w>s
nnoremap <silent> <Leader>O <C-w>o

"" Resizing
nnoremap <silent> <Down> <C-w>-
nnoremap <silent> <Up> <C-w>+
nnoremap <silent> <Left> <C-w><
nnoremap <silent> <Right> <C-w>>

""------------------------------------------------------------------------------
"" Normal: Tabs
""------------------------------------------------------------------------------

nnoremap <silent> <Leader>f :<C-u>tabprevious<CR>
nnoremap <silent> <Leader>b :<C-u>tabnext<CR>
nnoremap <silent> <Leader>t :<C-u>tabnew<CR>
nnoremap <silent> <Leader>> :<C-u>tabmove +<CR>
nnoremap <silent> <Leader>< :<C-u>tabmove -<CR>
nnoremap <silent> <Leader>T <C-w>T

""------------------------------------------------------------------------------
"" Normal: Buffers
""------------------------------------------------------------------------------

nnoremap <silent> <Leader>n :<C-u>bn<CR>
nnoremap <silent> <Leader>p :<C-u>bp<CR>
nnoremap <silent> <Leader>x <C-u>:bd<CR>
nnoremap <silent> <Leader>X :<C-u>%bd\|e#<CR>

""------------------------------------------------------------------------------
"" Normal: Goto
""------------------------------------------------------------------------------

nnoremap <silent> <Leader>g" :<C-u>reg<CR>
nnoremap <silent> <Leader>g: :<C-u>messages<CR>
nnoremap <silent> <Leader>gt :<C-u>tabs<CR>:tabnext<Space>
nnoremap <silent> <Leader>gb :<C-u>buffers<CR>:buffer<Space>

""------------------------------------------------------------------------------
"" Normal: Commands
""------------------------------------------------------------------------------

nnoremap <silent> <Leader>cp :<C-u>set paste!<CR>
nnoremap <silent> <Leader>cw :<C-u>set wrap!<CR>
nnoremap <Leader>cf :<C-u>set filetype=
nnoremap <Leader>cS :<C-u>%s//gc<Left><Left><Left>
nnoremap <expr> <Leader>cs ':<C-u>%s/' . @/ . '//gc<Left><Left><Left>'

""------------------------------------------------------------------------------
"" Insert: cursor movement
""------------------------------------------------------------------------------

inoremap <silent> <C-h> <left>
inoremap <silent> <C-j> <down>
inoremap <silent> <C-k> <up>
inoremap <silent> <C-l> <right>
inoremap <silent> <C-a> <Home>
inoremap <silent> <C-e> <End>

""------------------------------------------------------------------------------
"" All: Misc
""------------------------------------------------------------------------------

nnoremap <silent> <Leader>q :<C-u>q<CR>
nnoremap <silent> <Leader>Q :<C-u>qa<CR>
nnoremap <silent> <Leader>w :<C-u>w<CR>
nnoremap <silent> <Leader>W :<C-u>wa<CR>
nnoremap <silent> # :<C-u>noh<CR>
nnoremap <silent> * *N
vnoremap <silent> * y/\V<C-r>=escape(@",'/\')<CR><CR>N

""------------------------------------------------------------------------------
"" All: System Copy and paste
""------------------------------------------------------------------------------

nnoremap <silent> <Leader>uy "*yy
nnoremap <silent> <Leader>up :<C-u>set paste<CR>"*p:set nopaste<CR>
vnoremap <silent> <Leader>uy "*y
vnoremap <silent> <Leader>up :<C-u>set paste<CR>gv"*p:set nopaste<CR>
inoremap <silent> <Plug>(poi_clipboard_copy) <C-o>"*yy
inoremap <silent> <Plug>(poi_clipboard_paste) <C-o>:<C-u>set paste<CR><C-r>*<C-o>:set nopaste<CR>

""------------------------------------------------------------------------------
"" Terminal: Terminal related
""------------------------------------------------------------------------------

tnoremap <Esc><Esc> <C-\><C-n>
