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

# usage: _bash_style1_ <$UID>
function _BASH_PROMPT1_() {
    case "$1" in
        0) export PS1="[$(_CSI_ "\u@\h" "31m"):\W]# " ;;
        *) export PS1="[$(_CSI_ "\u@\h" "32m"):\W]$ " ;;
    esac
}

# usage: _bash_style1_ <$UID>
function _BASH_PROMPT2_() {
    case "$1" in
        0) export PS1="[$(_CSI_ "\u@\h" "31m"):\W \[\$?\]]# " ;;
        *) export PS1="[$(_CSI_ "\u@\h" "32m"):\W \[\$?\]]$ " ;;
    esac
}

# usage: _bash_style1_ <$UID>
function _BASH_PROMPT3_() {
    case "$1" in
        0) export PS1="$(_CSI_ "\u@\h" "31m") \w $(_RET_FACE_)\n+++ " ;;
        *) export PS1="$(_CSI_ "\u@\h" "32m") \w $(_RET_FACE_)\n--- " ;;
    esac
}