# Quick edit configuration file
RcConfig() { ([ ! -z $EDITOR ] && eval "$EDITOR $BASH_SOURCE") || vi $BASH_SOURCE }
# Load core file
eval ". $(dirname $(realpath $BASH_SOURCE))/bashrc.sh"
