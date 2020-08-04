alias ll="ls -lahF --color=always --group-directories-first"

# Fzf helper. Calls fzf with any command.
function fzfcmd {
    [ -z "$1" ] && return
    eval "$1 \$(fzf)"
}

function fzfcd {
    cd $(fzf)
}

# Ranger helper. Prevents from launching nested instances.
function rr {
    [ -n "$RANGER_LEVEL" ] && return
    ranger "$@"
}
