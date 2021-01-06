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

# Homebrew wrapper
function brew {
    export HOMEBREW_NO_AUTO_UPDATE=1
    PATH="/home/linuxbrew/.linuxbrew/bin:$PATH" /home/linuxbrew/.linuxbrew/bin/brew "$@"
}
