# Control Sequence Introducer
# usage: _csi_ <word> <csi_code>
function _CSI_() {
    echo "\[\e[${2}\]${1}\[\e[0m\]"
}

function _RET_() {
    local ret=$?
    echo "$ret"
}

function _RET_FACE_() {
    local ret=$?
    if [ "$ret" -ne 0 ]; then
        echo "$(_CSI_ ":(" "31m")"
    else
        echo "$(_CSI_ ":)" "32m")"
    fi
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
    case "$1" in
        0) export PS1="[$(_CSI_ "\u@\h" "31m"):\W]# ";;
        *) export PS1="[$(_CSI_ "\u@\h" "32m"):\W]$ ";;
    esac
}

# simple_with_return
function _PROMPT_SIMPLE_W_RET_() {
    case "$1" in
        0) export PS1="[$(_CSI_ "\u@\h" "31m"):\W \[\$?\]]# ";;
        *) export PS1="[$(_CSI_ "\u@\h" "32m"):\W \[\$?\]]$ ";;
    esac
}

# two_lines
function _PROMPT_TWO_LINES_() {
    case "$1" in
        0) export PS1="$(_CSI_ "\u@\h" "31m") \w $(_RET_FACE_)\n+++ ";;
        *) export PS1="$(_CSI_ "\u@\h" "32m") \w $(_RET_FACE_)\n--- ";;
    esac
}

# usage: PROMPT_SELECTOR <style> <UID>
function PROMPT_SELECTOR() {
    case "$1" in
        "simple") _PROMPT_SIMPLE_ $2;;
        "simple_with_return") _PROMPT_SIMPLE_W_RET_ $2;;
        "two_lines") _PROMPT_TWO_LINES_ $2;;
    esac
}