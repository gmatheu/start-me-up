
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3 &&
sudo apt-get update &&
sudo apt-get install sublime-text-installer

PKG_DIR="sublime-packages" 
mkdir $PKG_DIR
cd $PKG_DIR &&
wget "https://sublime.wbond.net/Package%20Control.sublime-package" &&
cp $PKG_DIR/* "~/.config/sublime-text-3/Installed Packages" &&
rm $PKG_DIR
CONF_DIR="~/.config/sublime-text-3/Packages/User"
cp sublime-settings/* $CONF_DIR 

cat > $CONF_DIR/SendToPasteBin.sublime-setings <<EOF
{
	"api_dev_key":  "$PASTE_BIN_API_KEY",
	"api_user_key": "$EMAIL",

	// 0 = Public, 1 = Unlisted, 2 = Private
	"paste_privacy": 1,

	// N = Never, 10M = 10 Minutes, 1H = 1 Hour, 1D = 1 Day, 1W = 1 Week, 2W = 2 Weeks, 1M = 1 Month
	"paste_expire_date": "1D"
}
EOF
