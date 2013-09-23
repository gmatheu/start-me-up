# git submodule add https://github.com/bgreenlee/sublime-github modules/sublime-text-3/Github
# git submodule add https://github.com/alienhard/SublimeAllAutocomplete modules/sublime-text-3/AllAutocomplete
# https://github.com/waynemoore/sublime-gherkin-formatter.git

wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3047_amd64.deb &&
sudo dpkg --install sublime-text_build-3047_amd64.deb &&
rm sublime-text_build-3047_amd64.deb

PKG_DIR="sublime-packages" 
mkdir $PKG_DIR
cd $PKG_DIR &&
wget "https://sublime.wbond.net/Package%20Control.sublime-package" &&
cp $PKG_DIR/* "~/.config/sublime-text-3/Installed Packages" &&
rm $PKG_DIR 
cp sublime-settings/* "~/.config/sublime-text-3/Packages/User"
