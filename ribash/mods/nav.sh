################################################################################
#
# CLI navigation commands
#
# Created by peromage 2021/02/26
# Last modified 2021/02/26
#
################################################################################

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------
# fzf
ffdo() {
    if [ -z "$1" ]; then
        echo "Usage: ffdo <prog>"
        return
    fi
    eval "$1 \$(fzf) $@"
}

ffcd() {
    local tmp="$(fzf)"
    [ -n "$tmp" ] && cd "$tmp"
}

ffnvim() {
    local tmp="$(fzf)"
    [ -n "$tmp" ] && nvim "$tmp"
}

ffvim() {
    local tmp="$(fzf)"
    [ -n "$tmp" ] && vim "$tmp"
}

# lf
lfcd() {
    local tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# ranger
ranger() {
    if [ -n "$RANGER_LEVEL" ]; then
        echo "nested ranger!"
        return
    fi
    ranger "$@"
}

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------
# z.lua
alias zb='z -b'
alias zc='z -c'
alias zi='z -i'
alias zf='z -I'
