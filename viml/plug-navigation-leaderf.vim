""" plug-navigation-leaderf.vim -- LeaderF settings

Plug 'Yggdroot/LeaderF', {'do': './install.sh'}

let g:Lf_ShowRelativePath = 1
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 1
let g:Lf_UseMemoryCache = 1
let g:Lf_UseVersionControlTool = 1
let g:Lf_IgnoreCurrentBufferName = 1
"let g:Lf_StlSeparator = {'left': "\ue0b0", 'right': "\ue0b2", 'font': 'DejaVu Sans Mono for Powerline'}
let g:Lf_ShowHidden = 1
let g:Lf_JumpToExistingWindow = 0
let g:Lf_WindowPosition = 'bottom'
let g:Lf_WindowHeight = '0.2'
let g:Lf_PreviewHorizontalPosition = 'right'
let g:Lf_PopupPreviewPosition = 'top'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {
\   'File': 0,
\   'Buffer': 0,
\   'Mru': 0,
\   'Tag': 0,
\   'BufTag': 0,
\   'Function': 0,
\   'Line': 0,
\   'Colorscheme': 0,
\   'Jumps': 0
\ }

nnoremap <silent> <C-p>f :<C-U>Leaderf file --no-ignore<CR>
nnoremap <silent> <C-p>m :<C-U>Leaderf mru<CR>
nnoremap <silent> <C-p>b :<C-U>Leaderf buffer<CR>
nnoremap <silent> <C-p>s :<C-U>Leaderf line --fuzzy<CR>
nnoremap <silent> <C-p>t :<C-U>Leaderf bufTag --fuzzy<CR>
nnoremap <silent> <C-p>T :<C-U>Leaderf tag --fuzzy<CR>
nnoremap <silent> <C-p>g :<C-U>Leaderf rg --fuzzy<CR>
nnoremap <silent> <C-p>G :<C-U>LeaderfRgInteractive<CR>
nnoremap <silent> <C-p>h :<C-U>Leaderf self<CR>
nnoremap <silent> <C-p>r :<C-U>Leaderf --recall<CR>
nnoremap <silent> <C-p>y :<C-U>Leaderf function --fuzzy<CR>
nnoremap <silent> <C-p>Y :<C-U>Leaderf function --all --fuzzy<CR>
