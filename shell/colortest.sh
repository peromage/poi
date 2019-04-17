width=7
word="gYm"

function printcolumnbg() {
    printf "%${width}s " ${1:3}
    printf "$1%${width}s " $2
    for i in {40..47}; do
        printf "$1\e[${i}m%${width}s\e[m " $2
    done
    printf "\n"
}

function colortest() {
    # header
    printf "%${width}s %${width}s " "code" "m"
    for i in {40..47}; do
        printf "%${width}s " "${i}m"
    done
    printf "\n" 
    # print row by row
    printcolumnbg "\e[m" $word
    printcolumnbg "\e[1m" $word
    for j in {30..37}; do
         printcolumnbg "\e[${j}m" $word
         printcolumnbg "\e[1;${j}m" $word
    done
}

colortest
