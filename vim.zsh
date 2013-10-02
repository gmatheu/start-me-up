#! /usr/bin/zsh

echo "Uninstalling Vim apt packages"
sudo apt-get -y purge vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-gnome &&
sudo apt-mark hold vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-gnome

if ! (which vim > /dev/null) 
  then
  echo "Installing Vim"
  sudo apt-get -y install libncurses5-dev libgnome2-dev libgnomeui-dev \
  libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
  libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev ruby-dev mercurial &&
  hg clone https://code.google.com/p/vim &&
  cd vim &&
  ./configure --with-features=huge \
              --enable-rubyinterp \
              --enable-pythoninterp \
              --with-python-config-dir=/usr/lib/python2.7-config \
              --enable-perlinterp \
              --enable-gui=gtk2 --enable-cscope --prefix=/usr &&
  make VIMRUNTIMEDIR=/usr/share/vim/vim74 &&
  sudo make install &&
  sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1 &&
  sudo update-alternatives --set editor /usr/bin/vim &&
  sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1 &&
  sudo update-alternatives --set vi /usr/bin/vim &&
  cd .. &&
  sudo rm -rf vim
else
  echo "Vim already installed"	
fi

echo "Installing Dot Vim files"
if [[ -d ~/.vim ]]
	then
	echo "Creating .vim backup"
	rm -rf ~/vim.bak
	mv ~/.vim ~/vim.bak
fi

git clone http://github.com/mutewinter/dot_vim.git ~/.vim &&
cd ~/.vim &&
rake vim:link &&
git clone http://github.com/gmarik/vundle.git bundle/vundle &&
vim "+mkspell ~/.vim/spell/custom.en.utf-8.add" +BundleInstall +qall &&
sudo apt-get install build-essential cmake python-dev &&
cd ~/.vim/bundle/YouCompleteMe &&
./install.sh