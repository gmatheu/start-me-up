#! /bin/sh

sudo sh -c 'echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu saucy main" | tee -a /etc/apt/sources.list'
sudo sh -c 'echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu saucy main" | tee -a /etc/apt/sources.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
sudo apt-get update
sudo apt-get -y install oracle-java7-installer
sudo apt-get -y install oracle-java8-installer
# sudo update-java-alternatives -s java-7-oracle
# sudo apt-get install oracle-java7-set-default
