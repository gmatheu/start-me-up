#! /bin/sh

if [ ! -n "$STU" ]; then
  STU=~/.start-me-up
fi

if [ ! -d $STU ]; 
then
  which git >/dev/null 2>&1 && \
  git clone https://github.com/gmatheu/start-me-up.git $STU || {
    echo 'Could not clone repository'
    exit 1
  }
fi

apt-get update
apt-get -y upgrade
apt-get install -y curl
sudo sh -c "`curl https://babushka.me/up/master`"

echo 
echo 'Starting up...'
cd $STU; babushka start-me-up home="$STU"
