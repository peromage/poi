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
# load utils
[ -f "$DIR/utils.sh" ] && source "$DIR/utils.sh"

# set bash theme
if [ -n "$BASH_VERSION" ]; then
    # Load theme
    if [ -f "$DIR/bash_themes.sh" ]; then
        source "$DIR/bash_themes.sh"
        _BASH_THEME2_ $UID
    fi
fi