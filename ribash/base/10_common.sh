################################################################################
#
# Common bash utilities
#
# Created by peromage 2021/02/24
# Last modified 2021/02/24
#
################################################################################

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------
# fzf
ffdo() {
    eval "$1 \$(fzf) $@"
}

ffcd() {
    cd $(fzf)
}

ffnvim() {
    nvim $(fzf)
}

ffvim() {
    vim $(fzf)
}

lfcd() {
    tmp="$(mktemp)"
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
alias ll="ls -lahF --color=always --group-directories-first"
alias msysupdate="pacman --needed -S bash pacman pacman-mirrors msys2-runtime"
alias brew="HOMEBREW_NO_AUTO_UPDATE=1 PATH=/home/linuxbrew/.linuxbrew/bin:$PATH /home/linuxbrew/.linuxbrew/bin/brew"
