" RC core initialization file for GUI
" Modified by peromage on 2021/01/20

function! g:RiceConfigInitGui() abort
    " Only proceeds following when rice configuration table presents
    if !exists('g:RICE_CONFIGS_GUI') || !(v:t_dict == type(g:RICE_CONFIGS_GUI))
        return
    endif
    " Configurations for neovim-qt
    if 'nvim-qt' == get(g:RICE_CONFIGS_GUI, 'frontend', 'null')
        echo 'Using nvim-qt'
        " Set font
        let l:val = get(g:RICE_CONFIGS_GUI, 'font', 0)
        if v:t_string == type(l:val)
            execute 'Guifont! '.l:val
        endif
        " Command to fix the display issue when moving window accross monitors
        " with difference DPIs
        command! GuiResetFont execute 'Guifont! '.GuiFont
        " Context menu
        nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
        inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
        vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
    endif

    " Gui common options
    set guioptions=mrb
endfunction
