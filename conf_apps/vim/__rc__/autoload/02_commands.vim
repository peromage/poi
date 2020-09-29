""
"" Created by peromage on 2020/06/04
""
"" Customized commands
""

" Close all but current buffers
command! Bdall :%bd|e#
" Toggle line numbers
command! ShowLines :set nu rnu scl=yes
command! NoShowLines :set nonu nornu scl=no
" Toggle paste mode
command! PasteMode :set paste
command! NoPasteMode :set nopaste
