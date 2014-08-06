#! /usr/bin/zsh

# Init dircolors
d=~/.dircolors
test -r $d && eval "$(dircolors $d)"
export GREP_COLOR='1;31'
