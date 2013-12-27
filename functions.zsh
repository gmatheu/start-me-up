#! /usr/bin/zsh

alias zsh_reload='source ~/.zshrc'
alias zshr='zsh_reload'

alias glo='git log --oneline --max-count=30'
compdef _git glo=git-log
alias glof='git log --pretty=format:"%C(yellow)%h%Creset %s %Cred%an%Creset %Cgreen%ad" --max-count=20  --date=relative'
compdef _git glof=git-log
alias gstl='git stash && git pull --rebase'

# Start an HTTP server from a directory, optionally specifying the port
 function server() {
     local port="${1:-8000}"
     sleep 1 && open "http://localhost:${port}/" &
     # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
     # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
     python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] =     value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
 }

 # Grep aliases
 function grep-aliases()
 {
 	alias | grep $1
 }

# Grep rails routes
function grep-rails-routes()
 {
 	rake routes | grep $1
 }

alias ga="grep-aliases"
alias rrg="grep-rails-routes"
alias rt="rake -T"
alias psg="ps aux | grep $@"
alias ack="ack-grep"

alias xc='xclip -selection clipboard'
alias xp='xclip'
alias xs='xclip -selection secondary'
alias xo='xclip -o'
alias xoc='xclip -o -selection clipboard'
alias xos='xclip -o -selection secondary'

alias save='echo "$@" >> ~/.saved'

# Tmux
alias txc='tmux show-buffer | xc' #Put Tmux buffer in the clipboard

#Sublime plugin fix 
if [[ $('uname') == 'Linux' ]]; then
        if [ -f '/usr/bin/subl' ]; then
                st_run() { nohup /usr/bin/subl $@ > /dev/null & }
        else
                st_run() { nohup /usr/bin/subl $@ > /dev/null & }
        fi
        alias st=st_run
fi

alias stt='st .'

unalias ag

if (which docker > /dev/null)
then
  alias docker='sudo docker'
fi

if (which memcached > /dev/null)
then
  alias clear_memcached='echo "flush_all" | nc localhost 11211'
  alias mccl='clear_memcached'
  alias mcc='telnet localhost 11211'
fi
