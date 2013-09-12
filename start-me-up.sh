#! /bin/bash

$PACKAGES="zsh tmux aptitude git guake curl openjdk-7-jre-headless maven autojump geany pidgin tree htop ack xclip vlc"
sudo apt-get update > /dev/null
sudo apt-get -y install $PACKAGES

# Zsh 
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
# Plugins plugins=(git git-extras rake autojump rvm vagrant rails history sublime bundler history-substring-search zsh-syntax-highlighting)
mkdir --parents ~/.oh-my-zsh/custom/plugins
cp functions.zsh ~/.oh-my-zsh/custom
cp -r ./modules/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins
sed -i -e /plugins=.*/plugins=\(git git-extras rake autojump rvm vagrant rails history sublime bundler zsh-syntax-highlighting history-substring-search debian tmux\)/g~/.zshrc
sed -i -e's/# DISABLE_CORRECTION/DISABLE_CORRECTION/g' ~/.zshrc
sed -i -e's/ZSH_THEME=\".*\"/ZSH_THEME=\"blinks\"/g' ~/.zshrc

# Highligting

# Git
EMAIL="gonzalommj@gmail.com"
git config --global user.name "Gonzalo Matheu"
git config --global user.email $EMAIL
git config --global core.pager ''
git config --global color.ui true

echo "Generating SSH keys"
ssh-keygen -t rsa -C $EMAIL 


# VBox
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian precise contrib" >> /etc/apt/sources.list.d/virtualbox.list'
sudo apt-get update > /dev/null
sudo apt-get -y install virtualbox-4.2
sudo apt-get -y install dkms

# Vagrant
wget http://files.vagrantup.com/packages/b12c7e8814171c1295ef82416ffe51e8a168a244/vagrant_1.3.1_i686.deb
sudo dpkg --install vagrant_1.3.1_i686.deb
rm vagrant_1.3.1_i686.deb

# Sublime
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3047_amd64.deb
sudo dpkg --install sublime-text_build-3047_amd64.deb
rm sublime-text_build-3047_amd64.deb

# Rvm/Ruby
curl -L https://get.rvm.io | bash -s stable --ruby
# source ~/.profile into .bashrc

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

# Vim
if ! (which vim > /dev/null) 
  then
  echo "Installing Vim"
  sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
  libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
  libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev mercurial checkinstall &&
  sudo apt-get purge vim vim-runtime gvim vim-tiny vim-common vim-gui-common &&
  hg clone https://code.google.com/p/vim &&
  cd vim &&
  ./configure --with-features=huge \
              --enable-rubyinterp \
              --enable-pythoninterp \
              --with-python-config-dir=/usr/lib/python2.7-config \
              --enable-perlinterp \
              --enable-gui=gtk2 --enable-cscope --prefix=/usr &&
  make VIMRUNTIMEDIR=/usr/share/vim/vim74 &&
  sudo checkinstall &&
  sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1 &&
  sudo update-alternatives --set editor /usr/bin/vim &&
  sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1 &&
  sudo update-alternatives --set vi /usr/bin/vim &&
  cd .. &&
  sudo rm -rf vim

  git clone http://github.com/mutewinter/dot_vim.git ~/.vim &&
  cd ~/.vim &&
  rake vim:link &&
  git clone http://github.com/gmarik/vundle.git bundle/vundle &&
  vim "+mkspell ~/.vim/spell/custom.en.utf-8.add" +BundleInstall +qall &&

  sudo apt-get install build-essential cmake python-dev &&
  cd ~/.vim/bundle/YouCompleteMe &&
  ./install.sh
fi

echo "Ubuntu"
echo "Nautilus Nav bar"
gsettings set org.gnome.nautilus.preferences always-use-location-entry true

echo "Solarized"
cp modules/dircolors.ansi-dark ~/.dircolors &&
eval `dircolors ~/.dircolors` &&
sh modules/gnome-terminal-colors-solarized/set_dark.sh &&
sh modules/guake-colors-solarized/set_dark.sh

