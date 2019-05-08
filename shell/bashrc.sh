#-----Initialization-----#
# interactive mode initialization script
# prevent from being loaded twice
if [ -z "$INIT_SH_LOADED" ]; then
    INIT_SH_LOADED=1
else
    return
fi

# if in non-interactive mode then exit
case "$-" in
    *i*) ;;
    *) return
esac

#-----Main-----#
# get current directory of init.sh
DIR=$(dirname $BASH_SOURCE)
# load modules
[ -f "$DIR/utils.sh" ] && source "$DIR/utils.sh"
[ -f "$DIR/alias.sh" ] && source "$DIR/alias.sh"

# set bash theme
if [ -n "$BASH_VERSION" ]; then
    # Load theme
    if [ -f "$DIR/bash_prompts.sh" ]; then
        source "$DIR/bash_prompts.sh"
        PROMPT_SELECTOR "simple_with_return" $UID
    fi
fi

#-----Cleanup-----#
unset DIR