#! /bin/sh

wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian precise contrib" >> /etc/apt/sources.list.d/virtualbox.list'
sudo apt-get update > /dev/null
sudo apt-get -y install virtualbox-4.2
sudo apt-get -y install dkms

