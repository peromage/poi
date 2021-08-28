""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" LeaderF settings
"
" Created by peromage 2021/02/24
" Last modified 2021/03/19
"
"Plug 'Yggdroot/LeaderF', { 'do': './install.sh'}
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_rice_plug_leaderf = 1

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

" Pre-defined shortcuts
nnoremap <silent> <Plug>(rice_leaderf_file) :<C-U>Leaderf file --no-ignore --fullPath
nnoremap <silent> <Plug>(rice_leaderf_mru) :<C-U>Leaderf mru --fullPath
nnoremap <silent> <Plug>(rice_leaderf_buffer) :<C-U>Leaderf buffer --fullPath
nnoremap <silent> <Plug>(rice_leaderf_buffer_tab) :<C-U>Leaderf buffer --tabpage --fullPath
nnoremap <silent> <Plug>(rice_leaderf_line) :<C-U>Leaderf line --all --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_line_buffer) :<C-U>Leaderf line --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_tag) :<C-U>Leaderf tag --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_tag_buffer) :<C-U>Leaderf bufTag --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_function) :<C-U>Leaderf function --all --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_function_buffer) :<C-U>Leaderf function --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_rg) :<C-U>Leaderf rg --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_rg_buffer) :<C-U>Leaderf rg --current-buffer --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_rg_all_buffers) :<C-U>Leaderf rg --all-buffers --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_rg_interactive) :<C-U>LeaderfRgInteractive
nnoremap <silent> <Plug>(rice_leaderf_self) :<C-U>Leaderf self
nnoremap <Plug>(rice_leaderf_prefix) :<C-U>Leaderf

" Global search
nmap <C-p>f <Plug>(rice_leaderf_file)<CR>
nmap <C-p>F <Plug>(rice_leaderf_function)<CR>
nmap <C-p>m <Plug>(rice_leaderf_mru)<CR>
nmap <C-p>b <Plug>(rice_leaderf_buffer)<CR>
nmap <C-p>B <Plug>(rice_leaderf_buffer_tab)<CR>
nmap <C-p>s <Plug>(rice_leaderf_line)<CR>
nmap <C-p>t <Plug>(rice_leaderf_tag)<CR>
nmap <C-p>g <Plug>(rice_leaderf_rg)<CR>

" Buffer search
nmap <C-p>es <Plug>(rice_leaderf_line_buffer)<CR>
nmap <C-p>et <Plug>(rice_leaderf_tag_buffer)<CR>
nmap <C-p>eF <Plug>(rice_leaderf_function_buffer)<CR>
nmap <C-p>eg <Plug>(rice_leaderf_rg_buffer)<CR>
nmap <C-p>eG <Plug>(rice_leaderf_rg_all_buffers)<CR>

" Word search
nmap <C-p>wf <Plug>(rice_leaderf_file) --cword<CR><Tab>
nmap <C-p>wF <Plug>(rice_leaderf_function) --cword<CR><Tab>
nmap <C-p>wb <Plug>(rice_leaderf_buffer) --cword<CR><Tab>
nmap <C-p>ws <Plug>(rice_leaderf_line) --cword<CR><Tab>
nmap <C-p>wt <Plug>(rice_leaderf_tag) --cword<CR><Tab>
nmap <C-p>wg <Plug>(rice_leaderf_rg) --cword<CR><Tab>

" Resume
nmap <C-p>rr <Plug>(rice_leaderf_prefix) --recall<CR><Tab>
nmap <C-p>rf <Plug>(rice_leaderf_file) --recall<CR><Tab>
nmap <C-p>rF <Plug>(rice_leaderf_function) --recall<CR><Tab>
nmap <C-p>rb <Plug>(rice_leaderf_buffer) --recall<CR><Tab>
nmap <C-p>rs <Plug>(rice_leaderf_line) --recall<CR><Tab>
nmap <C-p>rt <Plug>(rice_leaderf_tag) --recall<CR><Tab>
nmap <C-p>rg <Plug>(rice_leaderf_rg) --recall<CR><Tab>

" Interactive
nmap <C-p>ii <Plug>(rice_leaderf_self)<CR>
nmap <C-p>ig <Plug>(rice_leaderf_rg_interactive)<CR>
nmap <C-p>if <Plug>(rice_leaderf_prefix)<Space>
