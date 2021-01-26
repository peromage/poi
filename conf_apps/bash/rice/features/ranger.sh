# Ranger helpers.
# Modified by peromage on 2021/01/25

# Prevents from launching nested instances.
function ranger {
    [ -n "$RANGER_LEVEL" ] && return
    ranger "$@"
}
