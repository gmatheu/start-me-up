#! /bin/sh

NC='\033[0m'
error() {
  color='\033[0;31m'
  echo "${color}$1${NC} "
}
info() {
  color='\033[0;32m'
  echo "${color}$1${NC} "
}

LOG_FILE='last_run.log'
echo "Starting you up: `date`" > $LOG_FILE

if [ ! -n "$STU_HOME" ]; then
  export STU_HOME="$HOME/.start-me-up"
fi

install_prerequesites() {
  sudo apt-get update >/dev/null
  sudo apt-get -y upgrade
  sudo apt-get install -y curl git
}

get_repo() {
  if [ ! -d $STU_HOME ];
  then
    echo 'Cloning repository'
    which git >/dev/null 2>&1 && \
    git clone https://github.com/gmatheu/start-me-up.git $STU_HOME || {
      echo 'Could not clone repository'
      exit 1
    }
  else
    echo 'Updating Repository'
    cd $STU_HOME && \
      git pull origin master
  fi
}

get_babushka() {
  which babushka >/dev/null 2>&1 && \
  echo 'Babushka already installed' || {
   sudo sh -c "`curl -s https://babushka.me/up/master`" </dev/null
  }
  sudo babushka babushka
}

get_settings() {
  export FULL_NAME=`git config --global user.name` && \
  [ -z "${FULL_NAME}" ] && \
    echo -n 'Full Name: ' && read FULL_NAME && export FULL_NAME
  export EMAIL=`git config --global user.email` && \
  [ -z "${EMAIL}" ] && \
    echo -n 'E-mail: ' && read EMAIL && export EMAIL
}

run_babushka() {
  echo
  echo 'Starting up...'
  cd $STU_HOME; babushka start-me-up home="$STU_HOME"
}

# Run!
info "Getting latest changes"
get_repo
info 'Installing system packages'
install_prerequesites
info 'Installing babushka packages'
get_babushka
get_settings
# run_babushka

