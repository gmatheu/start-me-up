#! /bin/bash

STU_HOME=`pwd`
if [ ! -f $STU_HOME/secrets.sh ]; then
  echo "No secrets file defined!"
  exit 1
fi
source $STU_HOME/secrets.sh

echo "Adding ppa repositories"
sudo add-apt-repository -y ppa:git-core/ppa

# Git
git config --global user.name $NAME 
git config --global user.email $EMAIL
git config --global core.pager ''
git config --global color.ui true
git config --global merge.tool meld
git config --global diff.tool meld

echo "Generating SSH keys"
ssh-keygen -t rsa -C $EMAIL 

# Sublime
source $STU_HOME/sublime.sh

# Rvm/Ruby
curl -L https://get.rvm.io | bash -s stable --ruby --auto-dotfiles
# source ~/.profile into .bashrc
gem install pry guard

# Node
sudo apt-get -y python-software-properties python g++ make
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update > /dev/null
sudo apt-get -y install nodejs

# Heroku
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh


# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update > /dev/null
sudo apt-get -y install google-chrome-stable

## Firefox addons
# https://addons.mozilla.org/en-US/firefox/addon/vimfx/
# https://addons.mozilla.org/en-US/firefox/addon/session-manager/
# https://addons.mozilla.org/en-US/firefox/addon/firebug
# https://addons.mozilla.org/en-US/firefox/addon/poster
# https://addons.mozilla.org/en-US/firefox/addon/selenium-ide-button

# Skype
sudo sh -c "echo 'deb http://archive.canonical.com/ubuntu/ raring partner' >> /etc/apt/sources.list.d/canonical_partner.list"
sudo apt-get update > /dev/null
sudo apt-get install skype

source $STU_HOME/vim.zsh

echo "Ubuntu"
echo "Nautilus Nav bar"
gsettings set org.gnome.nautilus.preferences always-use-location-entry true

# The Silver Search
if ! (which ag > /dev/null); then
  sudo apt-get -y install software-properties-common &&
  sudo apt-add-repository -y ppa:mizuno-as/silversearcher-ag &&
  sudo apt-get update &&
  sudo apt-get -y install silversearcher-ag
fi

