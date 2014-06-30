#! /bin/sh

LOG_FILE='last_run.log'
echo "Starting you up: `date`" > $LOG_FILE

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y curl git

if [ ! -n "$STU" ]; then
  STU=~/.start-me-up
fi

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

which babushka >/dev/null 2>&1 && \
echo 'Babushka already installed' || {
 sudo sh -c "`curl -s https://babushka.me/up/master`" </dev/null
}

[ -z "${FULL_NAME}" ] && \
  echo -n 'Full Name: ' && read FULL_NAME
[ -z "${EMAIL}" ] && \
  echo -n 'E-mail: ' && read EMAIL

echo
echo 'Starting up...'
cd $STU; babushka start-me-up home="$STU"

# Following packages are not working properly, but they can be installed using apt
echo 'Installing remaining packages...'
install_non_babushkable() {
  local dep=$1
  local packages=$2
  sudo babushka "$dep" >> $LOG_FILE 2>&1
  sudo aptitude -y install "$packages"
}
install_non_babushkable 'docker' 'lxc-docker'
install_non_babushkable 'skype' 'skype'
install_non_babushkable 'google-chrome' 'google-chrome-stable'
install_non_babushkable 'virtualbox' 'virtualbox'
