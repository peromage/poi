""
"" Created by peromage on 2020/06/04
""
"" Customized commands
""

" Close all but current buffers
command! Bdall :%bd|e#
command! Showline :set nu rnu scl=yes
command! Noshowline :set nonu nornu scl=no
