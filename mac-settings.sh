#! /bin/sh


# https://help.ubuntu.com/community/AppleKeyboard
grep "fnmode=2" /etc/modprobe.d/hid_apple.conf > /dev/null ||
(echo "Setting default Fn keys" &&
  echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf &&
  sudo update-initramfs -u -k all)

# http://www.rierol.net/ubuntu-12.04-LTS-macbook-pro.html

# Fan Daemon
if ! (which mbpfan > /dev/null) 
  then
  echo "Fan Daemon"
  sudo aptitude install lm-sensors
  grep "coretemp" /etc/modules ||
  sudo cat >> /etc/modules <<EOF
coretemp
EOF
  grep "applesmc" /etc/modules ||
  sudo cat >> /etc/modules <<EOF
applesmc
EOF
  sudo modprobe
  cd modules/Fan-Control-Daemon &&
  make &&
  sudo make tests &&
  sudo make install &&
  sudo cp mbpfan.upstart /etc/init/mbpfan.conf &&
  sudo cat > /etc/mbpfan.conf <<EOF
[general]
min_fan_speed = 3000  # default is 2000
max_fan_speed = 6200  # default is 6200
low_temp = 55     # try ranges 55-63, default is 63
high_temp = 58      # try ranges 58-66, default is 66
max_temp = 86     # do not set it > 90, default is 86
polling_interval = 7  # default is 7
EOF &&
  sudo start mbpfan
fi