#! /bin/sh
# apt-get update
# apt-get -y upgrade
apt-get install -y curl
sh -c "`curl https://babushka.me/up`"
# mkdir --parents ~/.babushka
# ln -s ~/.stu/babushka-deps ~/.babushka/deps

echo 
echo 'Starting up...'
cd ~/.stu; babushka start-me-up
