#! /bin/bash

function stu-add-bintray-repo() {
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 41C23E8A4A7331E6
  echo "deb https://dl.bintray.com/gmatheu/deb /" | sudo tee /etc/apt/sources.list.d/gmatheu-bintray.list
  sudo apt-get update
}

export BABUSHKA_HOME=$HOME/.babushka
function install-babushka() {
  git clone https://github.com/benhoskings/babushka.git $BABUSHKA_HOME
  mkdir -p $HOME/bin
  ln -s $BABUSHKA_HOME/bin/babushka.rb $HOME/bin/babushka
} 
