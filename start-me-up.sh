#! /bin/bash

STU_HOME=`pwd`

$PACKAGES="zsh tmux aptitude git guake curl openjdk-7-source openjdk-7-doc openjdk-7-jdk maven autojump geany pidgin tree htop ack-grep xclip vlc meld"
sudo apt-get update > /dev/null
sudo apt-get -y install $PACKAGES

# Zsh 
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
# Plugins 
mkdir --parents ~/.oh-my-zsh/custom/plugins
ln -s $STU_HOME/functions.zsh $ZSH_CUSTOM/functions.zsh
cp -r ./modules/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
sed -i -e /plugins=.*/plugins=\(git git-extras rake autojump rvm vagrant rails history zsh-syntax-highlighting history-substring-search debian tmux\)/g~/.zshrc
echo "DEBIAN_PREVENT_KEYBOARD_CHANGES=yes" >> ~/.zshenv
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
./sublime.sh

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

# Vim
if ! (which vim > /dev/null) 
  then
  echo "Installing Vim"
  sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
  libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
  libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev mercurial checkinstall &&
  sudo apt-get purge vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-gnome &&
  sudo apt-mark hold vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-gnome
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


#Eclipse
# http://akovid.blogspot.com.br/2012/08/installing-eclipse-juno-42-in-ubuntu.html
if ! (which eclipse > /dev/null)
  then
  if [ -f eclipse ]; then
    sudo tar xf eclipse-jee-kepler-R-linux-gtk-x86_64.tar.gz -C /opt &&
    sudo mv /opt/eclipse /opt/eclipse-kepler &&
    sudo cat > /usr/share/applications/eclipse-kepler.desktop <<EOF
[Desktop Entry]
Name=Eclipse Kepler
Type=Application
Exec=/opt/eclipse-kepler/eclipse
Terminal=false
Icon=/opt/eclipse-kepler/icon.xpm
Comment=Integrated Development Environment
NoDisplay=false
Categories=Development;IDE
Name[en]=eclipse
EOF
    sudo ln -s /opt/eclipse-kepler/eclipse /usr/bin/eclipse-kepler
    sudo ln -s /usr/bin/eclipse-kepler /usr/bin/eclipse
  else 
    echo "eclipse-jee-kepler-R-linux-gtk-x86_64.tar.gz should be on this folder"
  fi
fi


#IntelliJ Idea
if ! (which idea > /dev/null)
  then
  if [ -f ideaIC-12.1.4.tar.gz ]; then
    IDEA_PREFIX="idea-IC-12"
    tar xf ideaIC-12.1.4.tar.gz &&
    find . -name "$IDEA_PREFIX*" -type d -exec mv {} $IDEA_PREFIX \; &&
    sudo mv $IDEA_PREFIX /opt &&
    sudo cat > /usr/share/applications/idea.desktop <<EOF
[Desktop Entry]
Name=IntelliJ Idea 12
Type=Application
Exec=/opt/idea-IC-12/bin/idea.sh
Terminal=false
Icon=/opt/idea-IC-12/bin/idea.png
Comment=Integrated Development Environment
NoDisplay=false
Categories=Development;IDE
Name[en]=Idea
EOF
    sudo ln -s /opt/$IDEA_PREFIX/bin/idea.sh /usr/bin/idea
  else 
    echo "ideaIC-12.1.4.tar.gz should be on this folder"
  fi
fi

# Hub
if ! (which hub > /dev/null); then
  sudo curl http://hub.github.com/standalone -sLo /bin/hub &&
  sudo chmod +x /bin/hub &&
  curl https://raw.github.com/github/hub/master/etc/hub.zsh_completion -o ~/.oh-my-zsh/custom/hub.zsh
fi

# The Silver Search
if ! (which ag > /dev/null); then
  sudo apt-get -y install software-properties-common &&
  sudo apt-add-repository -y ppa:mizuno-as/silversearcher-ag &&
  sudo apt-get update &&
  sudo apt-get -y install silversearcher-ag
fi

