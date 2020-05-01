let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {'Function':1, 'Colorscheme':1, 'BufTag': 1}
let g:Lf_StlSeparator = {'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline"}

let g:Lf_NormalMap = {
    \ "File": [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
	\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
	\ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
	\ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
	\ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
	\ "Colorscheme": [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
	\ }


let g:Lf_ShortcutF = "<leader>ff"
nnoremap <silent><C-p>pp :LeaderfFile<CR>
nnoremap <silent><C-p>bb :LeaderfBuffer<CR>
nnoremap <silent><C-p>mm :LeaderfMru<CR>
nnoremap <silent><C-p>tt :LeaderfTag<CR>
nnoremap <silent><C-p>bt :LeaderfBufTag<CR>
nnoremap <silent><C-p>ln :LeaderfLine<CR>
nnoremap <silent><C-p>ff :LeaderfFunction<CR>
