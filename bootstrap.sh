#! /bin/sh

LOG_FILE='last_run.log'
echo "Starting you up: `date`" > $LOG_FILE

if [ ! -n "$STU" ]; then
  export STU=~/.start-me-up
fi

install_prerequesites() {
  sudo apt-get update >/dev/null
  sudo apt-get -y upgrade
  sudo apt-get install -y curl git
}

get_repo() {
  if [ ! -d $STU ];
  then
    echo 'Cloning repository'
    which git >/dev/null 2>&1 && \
    git clone https://github.com/gmatheu/start-me-up.git $STU || {
      echo 'Could not clone repository'
      exit 1
    }
  else
    echo 'Updating Repository'
    cd $STU && \
      git pull origin master
  fi
}

get_babushka() {
  which babushka >/dev/null 2>&1 && \
  echo 'Babushka already installed' || {
   sudo sh -c "`curl -s https://babushka.me/up/master`" </dev/null
  }
}

get_settings() {
m export FULL_NAME=`git config --global user.name` && \
  [ -z "${FULL_NAME}" ] && \
    echo -n 'Full Name: ' && read FULL_NAME && export FULL_NAME
  export EMAIL=`git config --global user.email` && \
  [ -z "${EMAIL}" ] && \
    echo -n 'E-mail: ' && read EMAIL && export EMAIL
}

run_babushka() {
  echo
  echo 'Starting up...'
  cd $STU; babushka start-me-up home="$STU"
}

install_non_babushkable() {
  local dep=$1
  local packages=$2
  sudo babushka "$dep" >> $LOG_FILE 2>&1
  sudo aptitude -y install "$packages"
}

post_install() { 
  source ~/.zshrc
  update-vim-plugins
}

# Run!
install_prerequesites
get_repo
get_babushka
get_settings
run_babushka
# Following packages are not working properly, but they can be installed using apt
echo 'Installing remaining packages...'
install_non_babushkable 'docker' 'lxc-docker'
install_non_babushkable 'skype' 'skype'
install_non_babushkable 'google-chrome' 'google-chrome-stable'
install_non_babushkable 'virtualbox' 'virtualbox'
post_install

