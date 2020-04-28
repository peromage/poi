let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_PreviewResult = {'Function':0, 'Colorscheme':1, 'BufTag': 0}
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }

let g:Lf_NormalMap = {
    \ "File": [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
	\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
	\ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
	\ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
	\ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
	\ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
	\ }


let g:Lf_ShortcutF = "<leader>ff"
nnoremap <silent><C-p>ff :LeaderfFile<CR>
noremap <silent><C-p>bb :LeaderfBuffer<CR>
noremap <silent><C-p>mm :LeaderfMru<CR>
noremap <silent><C-p>tt :LeaderfTag<CR>
noremap <silent><C-p>bt :LeaderfBufTag<CR>
noremap <silent><C-p>ln :LeaderfLine<CR>

