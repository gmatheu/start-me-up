#! /usr/bin/zsh

# Init dircolors
d=~/.dircolors
test -r $d && eval "$(dircolors $d)"
export GREP_COLOR='1;31'

if [[ -s '/etc/zsh_command_not_found' ]]; then
    source '/etc/zsh_command_not_found'
fi
