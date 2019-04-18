# interactive mode initialization script
# prevent from being loaded twice
if [ -z "$_INIT_SH_LOADED" ]; then
    _INIT_SH_LOADED=1
else
    return
fi

# if in non-interactive mode then exit
case "$-" in
    *i*) ;;
    *) return
esac

# ============== functions ===========================
function _bash_prompt() {
    # backup last exit code
    pret=$?

    # print word in color
    # usage: pwic <word> <fgcolor>
    function pwic() {
        echo "\[\e[${2}m\]${1}\[\e[m\]"
    }

    # variables
    pemoji=""
    psymbol=""
    ppath="$(pwic "\w" "34")"
    ptime="$(date +"%H:%M")"
    pinfo="\u@\h"

    case "$pret" in
        0) pemoji="$(pwic ":)" "32")" ;;
        *) pemoji="$(pwic ":(" "31")" ;;
    esac

    case "$UID" in
        0)
            psymbol="#"
            pinfo="$(pwic $pinfo 31)"
            ;;
        *)
            psymbol="\$"
            pinfo="$(pwic $pinfo 32)"
            ;;
    esac

    PS1="${pinfo}:${ppath} ${pemoji} ${psymbol} "
}
# ====================================================
if [ -n "$BASH_VERSION" ]; then
    export PROMPT_COMMAND=_bash_prompt
#elif [ -n "$ZSH_VERSION"]; then

fi

