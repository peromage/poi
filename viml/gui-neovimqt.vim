""" gui-neovimqt.vim -- Neovim-qt related settings

let g:loaded_gui = 'neovim-qt'

" Disable popup menu
GuiPopupmenu 0

" Disable tabline
GuiTabline 0

" Context menu
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>

" Command to fix the display issue when moving window accross monitors
" with difference DPIs
command! GuiResetFont execute 'Guifont! '.GuiFont
GuiResetFont
