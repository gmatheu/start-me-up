#! /bin/sh
apt-get update
apt-get -y upgrade
apt-get install -y curl
sudo sh -c "`curl https://babushka.me/up/master`"

echo 
echo 'Starting up...'
cd ~/.stu; babushka start-me-up
