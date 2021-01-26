# Fzf helpers.
# Modified by peromage on 2021/01/25

function fzfdo {
    [ -z "$1" ] && return
    eval "$1 \$(fzf)"
}

function fzfcd {
    cd $(fzf)
}
