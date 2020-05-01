" General config
call defx#custom#option('_', {
    \ 'winwidth': 30,
    \ 'split': 'vertical',
    \ 'direction': 'topleft',
    \ 'show_ignored_files': 1,
    \ 'buffer_name': '',
    \ 'toggle': 1,
    \ 'resume': 1
    \ })

" Global keymaps
" Open Defx
nnoremap <silent><leader>e :Defx<CR>

" Keymaps when Defx is open
function! s:my_defx_keymaps() abort
    setl nospell
    setl signcolumn=no
    setl nonumber
    " Open files
    nnoremap <silent><buffer><expr> <CR>
        \ defx#is_directory() ?
        \ defx#do_action('open_or_close_tree') :
        \ defx#do_action('drop',)
    nnoremap <silent><buffer><expr> <BS> defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
    nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
    nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tabe')
    nnoremap <silent><buffer><expr> i defx#do_action('open')
    nnoremap <silent><buffer><expr> p defx#do_action('print')
    nnoremap <silent><buffer><expr> o
        \ defx#is_directory() ?
        \ defx#do_action('open_or_close_tree') :
        \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
    nnoremap <silent><buffer><expr> u defx#do_action('cd', ['..'])
    " File manipulation
    nnoremap <silent><buffer><expr> dy defx#do_action('copy')
    nnoremap <silent><buffer><expr> dp defx#do_action('paste')
    nnoremap <silent><buffer><expr> dm defx#do_action('rename')
    nnoremap <silent><buffer><expr> dD defx#do_action('remove')
    nnoremap <silent><buffer><expr> dd defx#do_action('move')
    nnoremap <silent><buffer><expr> dn defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> dh defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> dr defx#do_action('redraw')
    nnoremap <silent><buffer><expr> x defx#do_action('toggle_select')
    nnoremap <silent><buffer><expr> X defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> zp defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> zd defx#do_action('change_vim_cwd')
endfunction
autocmd FileType defx call s:my_defx_keymaps()

" Avoid the white space highting issue
"autocmd FileType defx match ExtraWhitespace /^^/

