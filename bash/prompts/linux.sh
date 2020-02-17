case "$UID" in
    0) export PS1='\[\e[31m\]\u@\h\[\e[0m\]:\W# ';;
    *) export PS1='\[\e[32m\]\u@\h\[\e[0m\]:\W$ ';;
esac
