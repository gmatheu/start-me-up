#! /bin/sh

wget http://apt.puppetlabs.com/puppetlabs-release-raring &&
sudo dpkg -i puppetlabs-release-raring &&
rm puppetlabs-release-raring

sudo apt-get update
sudo aptitudo -y install puppet-common puppet
