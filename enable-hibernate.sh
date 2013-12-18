#! /bin/bash

sudo sh -c cat > /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla <<EOF
[Re-enable hibernate by default]
Identity=unix-user:*
Action=org.freedesktop.upower.hibernate
ResultActive=yes
EOF

sudo update-grub 
sudo killall unity-panel-service
