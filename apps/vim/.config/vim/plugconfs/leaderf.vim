Plug 'Yggdroot/LeaderF', { 'do': './install.sh'}


let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
"let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {'Function':1, 'Colorscheme':1, 'BufTag': 1}
let g:Lf_StlSeparator = {'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline"}
let g:Lf_ShowHidden = 1

nnoremap <leader>ff :Leaderf<space>
nnoremap <silent> <leader>fp :Leaderf file<CR>
nnoremap <silent> <leader>fb :Leaderf buffer<CR>
nnoremap <silent> <leader>fm :Leaderf mru<CR>
nnoremap <silent> <leader>ft :Leaderf tag<CR>
nnoremap <silent> <leader>fs :Leaderf bufTag<CR>
nnoremap <silent> <leader>fl :Leaderf line<CR>
nnoremap <silent> <leader>frg :Leaderf rg<CR>
nnoremap <silent> <leader>fn :Leaderf --next<CR>
nnoremap <silent> <leader>fN :Leaderf --previous<CR>
nnoremap <silent> <leader>fF :Leaderf --recall<CR>
