### Init
# Interactive mode initialization script
# Prevent from being loaded twice
if [ -z "$INIT_SH_LOADED" ]; then
    INIT_SH_LOADED=1
else
    return
fi
# If in non-interactive mode then exit
case "$-" in
    *i*) ;;
    *) return
esac
### End init

### Main
# Set sub dir
_DIR=$(dirname $(realpath $BASH_SOURCE))
_MODULESDIR=$_DIR/modules
_STYLESDIR=$_DIR/styles
# End set sub dir

# Load modules
[ -f "$_MODULESDIR/aliases.sh" ] && . "$_MODULESDIR/aliases.sh"
# [ -f "$_MODULESDIR/test_utils.sh" ] && . "$_MODULESDIR/test_utils.sh"
# End load modules

# Set shell style
# For bash
if [ -n "$BASH_VERSION" ]; then
    # Load style
    if [ -f "$_STYLESDIR/cmder.sh" ]; then
        . "$_STYLESDIR/cmder.sh"
    fi
fi
# End set shell style
### End main

### Cleanup
unset _MODULESDIR
unset _STYLESDIR
### End Cleanup