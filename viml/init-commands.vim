""" init-commands.vim -- Ex commands

let g:loaded_poi_init_commands = 1

" Close all but current buffers
command! Bdall :%bd|e#

" Toggle line numbers
command! LineNumbers :set nu rnu scl=yes
command! NoLineNumbers :set nonu nornu scl=no

" Toggle paste mode
command! PasteMode :set paste
command! NoPasteMode :set nopaste
