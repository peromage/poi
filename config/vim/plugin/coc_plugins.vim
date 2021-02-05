" Coc plugin settings
" Modified by peromage on 2021/02/04

if !exists('g:did_coc_loaded') || !g:did_coc_loaded
    finish
endif

" File explorer
nnoremap <silent> <leader>e :CocCommand explorer --position left --sources buffer+,file+<CR> --toggle
