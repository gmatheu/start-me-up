#! /bin/sh

wget http://files.vagrantup.com/packages/0ac2a87388419b989c3c0d0318cc97df3b0ed27d/vagrant_1.3.4_i686.deb &&
sudo dpkg --install vagrant_1.3.4_i686.deb &&
rm vagrant_1.3.4_i686.deb

vagrant plugin install vagrant-hostmanager
