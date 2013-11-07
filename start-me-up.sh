#! /bin/bash

STU_HOME=`pwd`
if [ ! -f $STU_HOME/secrets.sh ]; then
  echo "No secrets file defined!"
  exit 1
fi
source $STU_HOME/secrets.sh

$PACKAGES="subversion zsh tmux aptitude git guake curl openjdk-7-source openjdk-7-doc openjdk-7-jdk maven autojump geany pidgin tree htop ack-grep xclip vlc meld"
sudo apt-get update > /dev/null
sudo apt-get -y install $PACKAGES

source $STU_HOME/oh-my-zsh.zsh

# Tmux conf
ln -s $STU_HOME/tmux.conf ~/.tmux.conf

# Git
git config --global user.name $NAME 
git config --global user.email $EMAIL
git config --global core.pager ''
git config --global color.ui true

echo "Generating SSH keys"
ssh-keygen -t rsa -C $EMAIL 

source $STU_HOME/virtualbox.sh
source $STU_HOME/vagrant.sh

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

echo "Solarized"
ln -s $STU_HOME/modules/dircolors.ansi-dark ~/.dircolors &&
eval `dircolors ~/.dircolors` &&
sh modules/gnome-terminal-colors-solarized/set_dark.sh &&
sh modules/guake-colors-solarized/set_dark.sh

# Natural Scrolling
sudo add-apt-repository -y ppa:zedtux/naturalscrolling &&                                                                                                        !555
sudo apt-get update &&
sudo apt-get install -y naturalscrolling

# Caffeine
sudo apt-add-repository ppa:caffeine-developers/ppa
sudo apt-get update &&
sudo apt-get install -y caffeine 

source $STU_HOME/eclipse.sh

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

source $STU_HOME/netflix.sh
source $STU_HOME/puppet.sh
