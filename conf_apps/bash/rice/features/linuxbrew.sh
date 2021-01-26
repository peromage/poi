# Linuxbrew helpers
# Modified by peromage on 2021/01/25

function brew {
    export HOMEBREW_NO_AUTO_UPDATE=1
    PATH="/home/linuxbrew/.linuxbrew/bin:$PATH" /home/linuxbrew/.linuxbrew/bin/brew "$@"
}
