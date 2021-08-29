""" misc-session-manager.vim -- Session manager

" Compatible with Vim
let s:SESSION_SAVE_DIR = simplify($HOME . '/vim_saved_sessions')

" Generate a template name of a new session.
" @return: A string of the new session name
function! s:NewSessionName() abort
    " session name: session-yyyymmdd_HHMMSS.vim
    return 'session-'.strftime('%Y%m%d_%H%M%S')
endfunction

" Generate a collection of saved sessions under session folder.
" @return A dict of session list where the key is the index and value is the
" path
function! s:GetSessionCollection() abort
    " __rc__/../saved_sessions
    let session_list = globpath(s:SESSION_SAVE_DIR, '*.vim', 0, 1)
    let session_collection = {}
    for i in range(len(session_list))
        let session_collection[i] = session_list[i]
    endfor
    return session_collection
endfunction

" Print a collection of saced sessions
function! s:PrintSessionCollection(collection) abort
    for [key, value] in items(a:collection)
        let file_name = fnamemodify(value, ':t')
        echo '['.key.']: '.file_name
    endfor
endfunction

" Interact with use on a session collection
" @callback: The callback funcref should accept two parameters: dict of
" session collection, the selected key. And return a bool indicating if the
" interactive prompt should be continued.
function! s:InteractiveSessionCollection(message, prompt, callback) abort
    let sessions = s:GetSessionCollection()
    while 1
        echo a:message
        call s:PrintSessionCollection(sessions)
        let user_input = trim(input(a:prompt))
        echo "\n"
        " Determine the choice
        if has_key(sessions, user_input)
            if !a:callback(sessions, user_input)
                break
            endif
        elseif 'q' == user_input || strlen(user_input) == 0
            echo 'No session selected. Quitting...'
            break
        else
            echoerr 'Invalid index!'
        endif
    endwhile
endfunction

" Save a session
function! s:SaveASession() abort
    " Append file suffix .vim
    let save_name = trim(input('Save as: ', s:NewSessionName())).'.vim'
    let save_full_path = simplify(s:SESSION_SAVE_DIR.'/'.save_name)
    " Check directory existence
    if !isdirectory(s:SESSION_SAVE_DIR)
        call mkdir(s:SESSION_SAVE_DIR, 'p')
    endif
    execute 'mksession '.save_full_path
endfunction

" Delete the session file and remove the entry from the dict
" The dict will be modified in-place
function! s:RemoveASession(sessions, key) abort
    call delete(a:sessions[a:key])
    unlet a:sessions[a:key]
endfunction

" Open a session
function! s:OpenSessionCallback(sessions, key) abort
    execute 'source '.a:sessions[a:key]
    " Delete the session file after loading
    call s:RemoveASession(a:sessions, a:key)
    return 0
endfunction

function! s:OpenSession() abort
    call s:InteractiveSessionCollection('Choose a session to open (q to quit):', 'Open: ', function('s:OpenSessionCallback'))
endfunction

" Remove a session
function! s:RemoveSessionCallback(sessions, key)
    call s:RemoveASession(a:sessions, a:key)
    return 1
endfunction

function! s:RemoveSession() abort
    call s:InteractiveSessionCollection('Choose a session to remove (q to quit):', 'Remove: ', function('s:RemoveSessionCallback'))
endfunction

" List sessions
function! s:ListSession() abort
    let sessions = s:GetSessionCollection()
    echo 'Saved sessions:'
    call s:PrintSessionCollection(sessions)
endfunction

" Defining some commands to call those functions
command! SaveSession call s:SaveASession()
command! ListSession call s:ListSession()
command! LoadSession call s:OpenSession()
command! RemoveSession call s:RemoveSession()
