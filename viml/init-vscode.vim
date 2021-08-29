""" init-vscode.vim -- VSCode related settings

"-------------------------------------------------------------------------------
" Helper functions
"-------------------------------------------------------------------------------
function! s:openVSCodeCommandsInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

let s:enabled_auto_insert_mode = 0
function! s:toggleAutoInsertMode()
    if s:enabled_auto_insert_mode
        augroup AutoInsertMode
            autocmd!
        augroup END
        let s:enabled_auto_insert_mode = 0
        echom 'Disabled AutoInsertMode'
        stopinsert
    else
        augroup AutoInsertMode
            autocmd!
            autocmd WinEnter * startinsert
        augroup END
        let s:enabled_auto_insert_mode = 1
        echom 'Enabled AutoInsertMode'
        startinsert
    endif
endfunction

"-------------------------------------------------------------------------------
" Settings to adapt GUI operations
"-------------------------------------------------------------------------------
set clipboard=unnamedplus

"-------------------------------------------------------------------------------
" Key bindings with the leader key
"-------------------------------------------------------------------------------
let g:mapleader="\<Space>"

"-------------------------------------------------------------------------------
" Nomal: Splitting
"-------------------------------------------------------------------------------
nmap <silent> <Leader>v :<C-U>call VSCodeCall('workbench.action.splitEditorRight')<CR>
nmap <silent> <Leader>V :<C-U>call VSCodeCall('workbench.action.splitEditorDown')<CR>

"-------------------------------------------------------------------------------
" Normal: Pane jump
"-------------------------------------------------------------------------------
nmap <silent> <Leader>h :<C-U>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nmap <silent> <Leader>j :<C-U>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nmap <silent> <Leader>k :<C-U>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nmap <silent> <Leader>l :<C-U>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
nmap <silent> <Leader>o :<C-U>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>

"-------------------------------------------------------------------------------
" Normal: Pane size adjustment
"-------------------------------------------------------------------------------
nmap <silent> <Up> :<C-U>call VSCodeNotify('workbench.action.increaseViewHeight')<CR>
nmap <silent> <Down> :<C-U>call VSCodeNotify('workbench.action.decreaseViewHeight')<CR>
nmap <silent> <Right> :<C-U>call VSCodeNotify('workbench.action.increaseViewWidth')<CR>
nmap <silent> <Left> :<C-U>call VSCodeNotify('workbench.action.decreaseViewWidth')<CR>
nmap <silent> <Leader>O :<C-U>call VSCodeNotify('workbench.action.joinAllGroups')<CR>

"-------------------------------------------------------------------------------
" Normal: Tabs
"-------------------------------------------------------------------------------
nmap <silent> <Leader>N :<C-U>call VSCodeCall('workbench.action.previousEditorInGroup')<CR>
nmap <silent> <Leader>n :<C-U>call VSCodeCall('workbench.action.nextEditorInGroup')<CR>
nmap <silent> <Leader>t :<C-U>tabnew<CR>

"-------------------------------------------------------------------------------
" Normal: Search and substitution
"-------------------------------------------------------------------------------
nmap <Leader>is :<C-U>%s//gc<Left><Left><Left>
nmap <expr> <Leader>iS ':%s/' . @/ . '//gc<Left><Left><Left>'
nmap <silent> # :<C-U>noh<CR>
nmap <silent> * *N

"-------------------------------------------------------------------------------
" Normal: Misc
"-------------------------------------------------------------------------------
nmap <silent> <Leader>q :<C-U>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nmap <silent> <Leader>Q :<C-U>call VSCodeNotify('workbench.action.closeAllEditors')<CR>
nmap <silent> <Leader>w :<C-U>call VSCodeNotify('workbench.action.files.save')<CR>
nmap <silent> <Leader>W :<C-U>call VSCodeNotify('workbench.action.files.saveAs')<CR>

"-------------------------------------------------------------------------------
" Visual: Search
"-------------------------------------------------------------------------------
vmap <silent> * y/\V<C-R>=escape(@",'/\')<CR><CR>N

"-------------------------------------------------------------------------------
" Make it easier with mouse
"-------------------------------------------------------------------------------
nmap <silent> <Tab>c :<C-U>call VSCodeNotify('editor.action.clipboardCopyAction')<CR>
nmap <silent> <Tab>v :<C-U>call VSCodeNotify('editor.action.clipboardPasteAction')<CR>
nmap <silent> <Tab>a :<C-U>call VSCodeNotify('editor.action.selectAll')<CR>
nmap <silent> <Tab><Tab> :<C-U>call <SID>toggleAutoInsertMode()<CR>
nmap <silent> <Enter> o<Esc>
