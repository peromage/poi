# Terminal color test
function colortest() {
    width=7
    word="gYm"

    # print columns with background colors
    # usage: pcbg <word> <color_code>
    pcbg() {
        printf "%${width}s " ${2:3}
        printf "$2%${width}s " $1
        for i in {40..47}; do
            printf "$2\e[${i}m%${width}s\e[0m " $1
        done
        printf "\n"
    }

    # header
    printf "%${width}s %${width}s " "code" "m"
    for i in {40..47}; do
        printf "%${width}s " "${i}m"
    done
    printf "\n" 
    # print row by row
    pcbg $word "\e[0m"
    pcbg $word "\e[1m"
    for j in {30..37}; do
         pcbg $word "\e[${j}m"
         pcbg $word "\e[1;${j}m"
    done

    unset pcbg
}

function fish_collapsed_pwd() {
    local pwd="$1"
    local home="$HOME"
    local size=${#home}
    [[ $# == 0 ]] && pwd="$PWD"
    [[ -z "$pwd" ]] && return
    if [[ "$pwd" == "/" ]]; then
        echo "/"
        return
    elif [[ "$pwd" == "$home" ]]; then
        echo "~"
        return
    fi
    [[ "$pwd" == "$home/"* ]] && pwd="~${pwd:$size}"
    if [[ -n "$BASH_VERSION" ]]; then
        local IFS="/"
        local elements=($pwd)
        local length=${#elements[@]}
        for ((i=0;i<length-1;i++)); do
            local elem=${elements[$i]}
            if [[ ${#elem} -gt 1 ]]; then
                elements[$i]=${elem:0:1}
            fi
        done
    else
        local elements=("${(s:/:)pwd}")
        local length=${#elements}
        for i in {1..$((length-1))}; do
            local elem=${elements[$i]}
            if [[ ${#elem} > 1 ]]; then
                elements[$i]=${elem[1]}
            fi
        done
    fi
    local IFS="/"
    echo "${elements[*]}"
}