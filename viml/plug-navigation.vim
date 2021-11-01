""" plug-navigation.vim -- Navigation plugins

""------------------------------------------------------------------------------
"" Netrw
""------------------------------------------------------------------------------

"" Settings when netrw is open
function! s:my_netrw() abort
    setl nospell
    setl signcolumn=no
    setl nonumber
    setl norelativenumber
    setl cursorline
    setl cursorcolumn
endfunction

let g:netrw_altfile = 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_sizestyle = 'H'
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_alto = 1
let g:netrw_winsize = 20
let g:netrw_cursor = 4
let g:netrw_fastbrowse = 1
let g:netrw_hide = 1
let g:netrw_keepdir = 1
let g:netrw_usetab = 0
let g:netrw_preview = 0

autocmd FileType netrw call <SID>my_netrw()
nnoremap <silent> <leader>gd :<C-U>Lexplore<CR>

""------------------------------------------------------------------------------
"" Startify
""------------------------------------------------------------------------------

"" Startup screen
Plug 'mhinz/vim-startify'
"" Don't change working directory automatically
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
"" Session
let g:startify_session_autoload = 0
let g:startify_session_delete_buffers = 1
let g:startify_session_persistence = 1
"" Banner
let g:startify_fortune_use_unicode = 0
"" List
let g:startify_relative_path = 0
let g:startify_enable_special = 1
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
