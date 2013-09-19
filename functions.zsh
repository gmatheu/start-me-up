alias glo='git log --oneline --max-count=30'
compdef _git glo=git-log
alias glof='git log --pretty=format:"%C(yellow)%h%Creset %s %Cred%an%Creset %Cgreen%ad" --max-count=20  --date=relative'
compdef _git glof=git-log

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

alias ag="grep-aliases"
alias rrg="grep-rails-routes"
alias rt="rake -T"

alias xc='xclip -selection clipboard'
alias xp='xclip'
alias xs='xclip -selection secondary'
alias xo='xclip -o'
alias xoc='xclip -o -selection clipboard'
alias xos='xclip -o -selection secondary'

alias save='echo "$@" >> ~/.saved'