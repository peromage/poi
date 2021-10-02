""" init-lib.vim -- Ex commands and utility functions

" Close all but current buffers
command! Bdall :%bd|e#

" Toggle line numbers
command! LineNumbers :set nu rnu scl=yes
command! NoLineNumbers :set nonu nornu scl=no

" Toggle paste mode
command! PasteMode :set paste
command! NoPasteMode :set nopaste
