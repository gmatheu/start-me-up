#! /bin/sh

sudo add-apt-repository -y ppa:tualatrix/ppa &&
sudo apt-get update &&
sudo apt-get -y install ubuntu-tweak

sudo add-apt-repository -y ppa:scopes-packagers/ppa &&
sudo apt-get update &&
sudo apt-get -y install unity-lens-utilities unity-scope-calculator
