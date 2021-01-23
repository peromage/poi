" Configuration for neovim-qt
" Modified by peromage on 2021/01/23

function! rice#gui#neovimqt#init()
    if !exists('g:GuiLoaded')
        return 0
    endif
    echom 'neovim-qt detected'

    " Set font
    if g:rice_gui_font !=# ''
        execute 'Guifont! '.g:rice_gui_font
    endif
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
    return 1
endfunction
