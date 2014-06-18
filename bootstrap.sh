#! /bin/sh

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y curl git

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

sudo sh -c "`curl https://babushka.me/up/master`" </dev/null

echo 
echo 'Starting up...'
cd $STU; babushka start-me-up home="$STU"
