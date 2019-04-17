# interactive mode initialization script
## prevent from being loaded twice
#if [ -z "$_INIT_SH_LOADED" ]; then
#    _INIT_SH_LOADED=1
#else
#    return
#fi

# if in non-interactive mode then exit
case "$-" in
    *i*) ;;
    *) return
esac

# ============== functions ===========================
function _prompt() {
    ext=$?
    ret_code=""
    user_status=""

    case "$ext" in
        0) ret_code="\[\e[32m\]:)\[\e[m\]" ;;
        *) ret_code="\[\e[31m\]:(\[\e[m\]" ;;
    esac

    case "$UID" in
        0) user_status="\[\e[31m\]#\[\e[m\]" ;;
        *) user_status="\[\e[32m\]\$\[\e[m\]" ;;
    esac

    PS1="$ret_code \[\e[34m\]\w\[\e[m\] $user_status "
}
# ====================================================
if [ -n "$BASH_VERSION" ]; then
    export PROMPT_COMMAND=_prompt
#elif [ -n "$ZSH_VERSION"]; then

fi

