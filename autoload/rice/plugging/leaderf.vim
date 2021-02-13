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
nnoremap <silent> <Plug>(rice_leaderf_file) :Leaderf file --no-ignore --fullPath
nnoremap <silent> <Plug>(rice_leaderf_mru) :Leaderf mru --fullPath
nnoremap <silent> <Plug>(rice_leaderf_buffer) :Leaderf buffer --fullPath
nnoremap <silent> <Plug>(rice_leaderf_buffer_tab) :Leaderf buffer --tabpage --fullPath
nnoremap <silent> <Plug>(rice_leaderf_line) :Leaderf line --all --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_line_buffer) :Leaderf line --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_tag) :Leaderf tag --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_tag_buffer) :Leaderf bufTag --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_function) :Leaderf function --all --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_function_buffer) :Leaderf function --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_rg) :Leaderf rg --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_rg_buffer) :Leaderf rg --current-buffer --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_rg_all_buffers) :Leaderf rg --all-buffers --fuzzy
nnoremap <silent> <Plug>(rice_leaderf_rg_interactive) :LeaderfRgInteractive
nnoremap <silent> <Plug>(rice_leaderf_self) :Leaderf self
nnoremap <Plug>(rice_leaderf_prefix) :Leaderf<Space>

" Global search
nmap <silent> <leader>fp <Plug>(rice_leaderf_file)<CR>
nmap <silent> <leader>fm <Plug>(rice_leaderf_mru)<CR>
nmap <silent> <leader>fb <Plug>(rice_leaderf_buffer)<CR>
nmap <silent> <leader>fB <Plug>(rice_leaderf_buffer_tab)<CR>
nmap <silent> <leader>fl <Plug>(rice_leaderf_line)<CR>
nmap <silent> <leader>ft <Plug>(rice_leaderf_tag)<CR>
nmap <silent> <leader>ff <Plug>(rice_leaderf_function)<CR>
nmap <silent> <leader>fg <Plug>(rice_leaderf_rg)<CR>

" Buffer search
nmap <silent> <leader>fel <Plug>(rice_leaderf_line_buffer)<CR>
nmap <silent> <leader>fet <Plug>(rice_leaderf_tag_buffer)<CR>
nmap <silent> <leader>fef <Plug>(rice_leaderf_function_buffer)<CR>
nmap <silent> <leader>feg <Plug>(rice_leaderf_rg_buffer)<CR>
nmap <silent> <leader>feG <Plug>(rice_leaderf_rg_all_buffers)<CR>

" Word search
nmap <silent> <leader>fwp <Plug>(rice_leaderf_file) --cword<CR><Tab>
nmap <silent> <leader>fwb <Plug>(rice_leaderf_buffer) --cword<CR><Tab>
nmap <silent> <leader>fwl <Plug>(rice_leaderf_line) --cword<CR><Tab>
nmap <silent> <leader>fwt <Plug>(rice_leaderf_tag) --cword<CR><Tab>
nmap <silent> <leader>fwf <Plug>(rice_leaderf_function) --cword<CR><Tab>
nmap <silent> <leader>fwg <Plug>(rice_leaderf_rg) --cword<CR><Tab>

" Resume
nmap <silent> <leader>frr :Leaderf --recall<CR><Tab>
nmap <silent> <leader>frp <Plug>(rice_leaderf_file) --recall<CR><Tab>
nmap <silent> <leader>frb <Plug>(rice_leaderf_buffer) --recall<CR><Tab>
nmap <silent> <leader>frl <Plug>(rice_leaderf_line) --recall<CR><Tab>
nmap <silent> <leader>frt <Plug>(rice_leaderf_tag) --recall<CR><Tab>
nmap <silent> <leader>frf <Plug>(rice_leaderf_function) --recall<CR><Tab>
nmap <silent> <leader>frg <Plug>(rice_leaderf_rg) --recall<CR><Tab>

" Interactive
nmap <silent> <leader>fii <Plug>(rice_leaderf_self)<CR>
nmap <silent> <leader>fig <Plug>(rice_leaderf_rg_interactive)<CR>
nmap <leader>fif <Plug>(rice_leaderf_prefix)
