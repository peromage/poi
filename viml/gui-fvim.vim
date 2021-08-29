""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" FVim settings
"
" Created by peromage 2021/03/14
" Last modified 2021/03/18
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_poi_gui = 'fvim'

" Some fancy cursor effects
FVimCursorSmoothMove v:true
FVimCursorSmoothBlink v:true
FVimCustomTitleBar v:true
FVimUIPopupMenu v:false

" Font
FVimFontAntialias v:true
FVimFontAutohint v:true
FVimFontHintLevel 'full'
FVimFontLigature v:true
" can be 'default', '14.0', '-1.0' etc.
FVimFontLineHeight 'default'
FVimFontSubpixel v:true
" Disable built-in Nerd font symbols
"FVimFontNoBuiltInSymbols v:false
FVimFontAutoSnap v:true
FVimFontNormalWeight 100
FVimFontBoldWeight 600

" Ctrl-ScrollWheel for zooming in/out
nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
nnoremap <A-CR> :FVimToggleFullScreen<CR>
