alias ll="ls -lahF --color=always --group-directories-first"
alias nv="nvim"

# Fzf helper. Calls fzf with any command.
function fz {
    if [ -z "$1" ]; then
        echo "A command must be given!"
        return
    fi
    eval "$1 \$(fzf)"
}

# Ranger helper. Prevents from launching nested instances.
function rr {
    if [ -z "$RANGER_LEVEL" ]; then
        ranger "$@"
    else
        exit
    fi
}

# Check if in ranger nested shell
function rrin {
    if [ -z "$RANGER_LEVEL" ]; then
        echo "Not in ranger"
    else
        echo "In ranger level: $RANGER_LEVEL"
    fi
}
