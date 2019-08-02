function _RET_FACE_COLOR_() {
    case "$?" in
        0) echo -e '\e[32m:)\e[0m';;
        *) echo -e '\e[31m:(\e[0m';;
    esac
}

function _RET_FACE_() {
    case "$?" in
        0) echo ':)';;
        *) echo ':(';;
    esac
}

function _PWD_FISH_COLLAPSED_() {
    local pwd="$1"
    local home="$HOME"
    local size=${#home}
    [[ $# == 0 ]] && pwd="$PWD"
    [[ -z "$pwd" ]] && return
    if [[ "$pwd" == "/" ]]; then
        echo "/"
        return
    elif [[ "$pwd" == "$home" ]]; then
        echo "~"
        return
    fi
    [[ "$pwd" == "$home/"* ]] && pwd="~${pwd:$size}"
    if [[ -n "$BASH_VERSION" ]]; then
        local IFS="/"
        local elements=($pwd)
        local length=${#elements[@]}
        for ((i=0;i<length-1;i++)); do
            local elem=${elements[$i]}
            if [[ ${#elem} -gt 1 ]]; then
                elements[$i]=${elem:0:1}
            fi
        done
    else
        local elements=("${(s:/:)pwd}")
        local length=${#elements}
        for i in {1..$((length-1))}; do
            local elem=${elements[$i]}
            if [[ ${#elem} > 1 ]]; then
                elements[$i]=${elem[1]}
            fi
        done
    fi
    local IFS="/"
    echo "${elements[*]}"
}

#----- Styles -----#
# simple
function _PROMPT_SIMPLE_() {
    case "$UID" in
        0) export PS1='[\[\e[31m\]\u@\h\[\e[0m\]:\W]# ';;
        *) export PS1='[\[\e[32m\]\u@\h\[\e[0m\]:\W]$ ';;
    esac
}

# two_lines
function _PROMPT_TWO_LINES_() {
    case "$UID" in
        0) export PS1=' \[\e[31m\]\u@\h\[\e[0m\]:\[\e[33m\]\w\[\e[0m\] \[\e[37m\][\d \A]\[\e[0m\]\n $(_RET_FACE_COLOR_) +++ ';;
        *) export PS1=' \[\e[32m\]\u@\h\[\e[0m\]:\[\e[33m\]\w\[\e[0m\] \[\e[37m\][\d \A]\[\e[0m\]\n $(_RET_FACE_COLOR_) --- ';;
    esac
}

# usage: PROMPT_SELECTOR <style> <UID>
function PROMPT_SELECTOR() {
    case "$1" in
        "simple") _PROMPT_SIMPLE_;;
        "two_lines") _PROMPT_TWO_LINES_;;
    esac
}