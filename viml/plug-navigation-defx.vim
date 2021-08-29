""" plug-navigation-defx.vim -- Defx settings

let g:loaded_poi_plug_navigation_defx = 1

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" General config
call defx#custom#option('_', {
    \ 'winwidth': 30,
    \ 'split': 'vertical',
    \ 'direction': 'topleft',
    \ 'show_ignored_files': 1,
    \ 'buffer_name': '',
    \ 'toggle': 1,
    \ 'resume': 1,
    \ 'sort': 'filename'
    \ })

" Global keymaps
" Open Defx
nnoremap <silent> <Leader>d :<C-U>Defx<CR>

" Keymaps when Defx is open
function! s:my_defx_keymaps() abort
    setl nospell
    setl signcolumn=no
    setl nonumber
    setl norelativenumber
    setl cursorline
    setl cursorcolumn
    let l:sid = matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
    " Open files
    nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
    nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
    nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tab')
    nnoremap <silent><buffer><expr> p defx#do_action('print')
    nnoremap <silent><buffer><expr> o
        \ defx#is_directory() ?
        \ defx#do_action('open_or_close_tree') :
        \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> <CR>
        \ defx#is_directory() ?
        \ defx#do_action('open_or_close_tree') :
        \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> u defx#do_action('multi', [['cd', '..'], 'change_vim_cwd'])
    nnoremap <silent><buffer><expr> U defx#do_action('open_tree_recursive')
    nnoremap <silent><buffer><expr> O defx#do_action('multi', ['open_directory','change_vim_cwd'])
    nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
    " File manipulation
    nnoremap <silent><buffer><expr> yy defx#do_action('copy')
    nnoremap <silent><buffer><expr> pp defx#do_action('paste')
    nnoremap <silent><buffer><expr> dD defx#do_action('remove')
    nnoremap <silent><buffer><expr> dd defx#do_action('move')
    nnoremap <silent><buffer><expr> zn defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> zh defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> zr defx#do_action('redraw')
    nnoremap <silent><buffer><expr> zp defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> zm defx#do_action('rename')
    nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
    nnoremap <silent><buffer><expr> x defx#do_action('toggle_select')
    nnoremap <silent><buffer><expr> zx defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> zv defx#do_action('toggle_select_visual')
endfunction
autocmd FileType defx call s:my_defx_keymaps()

" Avoid the white space highting issue
"autocmd FileType defx match ExtraWhitespace /^^/
