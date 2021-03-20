""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Rice setup entry for VSCode
"
" Created by peromage 2021/03/14
" Last modified 2021/03/18
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
" Check if VSCode is enabled
"-------------------------------------------------------------------------------
if !rice#check_var('rice_vscode_use_config') | finish | endif

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
nmap <silent> <Leader>v :call VSCodeCall('workbench.action.splitEditorRight')<CR>
nmap <silent> <Leader>V :call VSCodeCall('workbench.action.splitEditorDown')<CR>

"-------------------------------------------------------------------------------
" Normal: Pane jump
"-------------------------------------------------------------------------------
nmap <silent> <Leader>h :call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nmap <silent> <Leader>j :call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nmap <silent> <Leader>k :call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nmap <silent> <Leader>l :call VSCodeNotify('workbench.action.focusRightGroup')<CR>
nmap <silent> <Leader>o :call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>

"-------------------------------------------------------------------------------
" Normal: Pane size adjustment
"-------------------------------------------------------------------------------
nmap <silent> <Up> :call VSCodeNotify('workbench.action.increaseViewHeight')<CR>
nmap <silent> <Down> :call VSCodeNotify('workbench.action.decreaseViewHeight')<CR>
nmap <silent> <Right> :call VSCodeNotify('workbench.action.increaseViewWidth')<CR>
nmap <silent> <Left> :call VSCodeNotify('workbench.action.decreaseViewWidth')<CR>
nmap <silent> <Leader>O :call VSCodeNotify('workbench.action.joinAllGroups')<CR>

"-------------------------------------------------------------------------------
" Normal: Tabs
"-------------------------------------------------------------------------------
nmap <silent> <Leader>N :call VSCodeCall('workbench.action.previousEditorInGroup')<CR>
nmap <silent> <Leader>n :call VSCodeCall('workbench.action.nextEditorInGroup')<CR>
nmap <silent> <Leader>t :tabnew<CR>

"-------------------------------------------------------------------------------
" Normal: Search and substitution
"-------------------------------------------------------------------------------
nmap <Leader>is :%s//gc<Left><Left><Left>
nmap <expr> <Leader>iS ':%s/' . @/ . '//gc<Left><Left><Left>'
nmap <silent> # :noh<CR>
nmap <silent> * *N

"-------------------------------------------------------------------------------
" Normal: Misc
"-------------------------------------------------------------------------------
nmap <silent> <Leader>q :call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nmap <silent> <Leader>Q :call VSCodeNotify('workbench.action.closeAllEditors')<CR>
nmap <silent> <Leader>w :call VSCodeNotify('workbench.action.files.save')<CR>
nmap <silent> <Leader>W :call VSCodeNotify('workbench.action.files.saveAs')<CR>

"-------------------------------------------------------------------------------
" Visual: Search
"-------------------------------------------------------------------------------
vmap <silent> * y/\V<C-R>=escape(@",'/\')<CR><CR>N

"-------------------------------------------------------------------------------
" Make it easier with mouse
"-------------------------------------------------------------------------------
nmap <silent> <Leader>c :call VSCodeNotify('editor.action.clipboardCopyAction')<CR>
nmap <silent> <Leader>v :call VSCodeNotify('editor.action.clipboardPasteAction')<CR>
nmap <silent> <Leader>a :call VSCodeNotify('editor.action.selectAll')<CR>
nmap <silent> <Tab> <Insert>
