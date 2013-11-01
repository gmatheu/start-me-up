#! /bin/sh

sudo sh 'echo deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
    sudo apt-key add -
sudo apt-get update
