#! /bin/sh

echo "Setting default Fn keys"
# https://help.ubuntu.com/community/AppleKeyboard
echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u -k all