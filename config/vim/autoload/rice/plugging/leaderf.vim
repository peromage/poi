" LeaderF settings
" Modified by peromage on 2021/02/05

if exists('g:loaded_rice_leaderf')
    finish
endif
let g:loaded_rice_leaderf = 1
Plug 'Yggdroot/LeaderF', { 'do': './install.sh'}

let g:Lf_ShowRelativePath = 1
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 1
let g:Lf_UseVersionControlTool = 1
let g:Lf_IgnoreCurrentBufferName = 1
"let g:Lf_StlSeparator = {'left': "\ue0b0", 'right': "\ue0b2", 'font': 'DejaVu Sans Mono for Powerline'}
let g:Lf_ShowHidden = 1
let g:Lf_JumpToExistingWindow = 0
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewHorizontalPosition = 'right'
let g:Lf_PopupPreviewPosition = 'top'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {
    \ 'File': 1,
    \ 'Buffer': 1,
    \ 'Mru': 1,
    \ 'Tag': 1,
    \ 'BufTag': 1,
    \ 'Function': 1,
    \ 'Line': 1,
    \ 'Colorscheme': 1,
    \ 'Jumps': 1
    \}

nnoremap <leader>fF :Leaderf<space>
nnoremap <silent> <leader>fp :Leaderf file --no-ignore<CR>
nnoremap <silent> <leader>fb :Leaderf buffer<CR>
nnoremap <silent> <leader>fm :Leaderf mru<CR>
nnoremap <silent> <leader>ft :Leaderf tag<CR>
nnoremap <silent> <leader>fT :Leaderf bufTag<CR>
nnoremap <silent> <leader>fl :Leaderf line<CR>
nnoremap <silent> <leader>f# :Leaderf line --cword<CR>
nnoremap <silent> <leader>fg :Leaderf rg<CR>
nnoremap <silent> <leader>fG :Leaderf rg --all-buffers<CR>
nnoremap <silent> <leader>f* :Leaderf rg --cword<CR>
nnoremap <silent> <leader>fn :Leaderf --next<CR>
nnoremap <silent> <leader>fN :Leaderf --previous<CR>
nnoremap <silent> <leader>ff :Leaderf --recall<CR>
nnoremap <silent> <leader>fh :Leaderf searchHistory<CR>
nnoremap <silent> <leader>fw :Leaderf window<CR>
nnoremap <silent> <leader>fi :Leaderf self<CR>
