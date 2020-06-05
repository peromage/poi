alias ll="ls -lahF --color=always --group-directories-first"
alias nv="nvim"
alias nvv="nvim \$(fzf)"
alias cdd="cd \$(fzf)"

# Fzf helper. Calls fzf with any command.
function fo {
    if [ -z "$1" ]; then
        echo "A command must be given!"
        return
    fi
    eval "$1 \$(fzf)"
}

# Ranger helper. Prevents from launching nested instances.
function lr {
    if [ -z "$RANGER_LEVEL" ]; then
        ranger "$@"
    else
        exit
    fi
}

# Check if in ranger nested shell
function lrin {
    if [ -z "$RANGER_LEVEL" ]; then
        echo "Not in ranger"
    else
        echo "In ranger level: $RANGER_LEVEL"
    fi
}
