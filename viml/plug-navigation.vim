""" plug-navigation.vim -- Navigation plugins

let g:loaded_poi_plug_navigation = 1

" Startup screen
Plug 'mhinz/vim-startify'
let g:loaded_poi_plug_startify = 1
" Don't change working directory automatically
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
" Session
let g:startify_session_autoload = 0
let g:startify_session_delete_buffers = 1
let g:startify_session_persistence = 1
" Banner
let g:startify_fortune_use_unicode = 0
" List
let g:startify_relative_path = 0
let g:startify_enable_special = 1
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]


PoiInclude plug-navigation-leaderf
