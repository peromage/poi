""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" NeoVim-qt settings
"
" Created by peromage 2021/02/24
" Last modified 2021/03/18
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_rice_gui = 'neovim-qt'

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
