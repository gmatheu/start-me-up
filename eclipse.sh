#! /bin/bash

# http://akovid.blogspot.com.br/2012/08/installing-eclipse-juno-42-in-ubuntu.html
if ! (which eclipse > /dev/null)
  then

	if [ $(uname -m) == 'x86_64' ]; then
		eclipse_file="eclipse-jee-kepler-R-linux-gtk-x86_64.tar.gz"
	else
		eclipse_file="eclipse-jee-kepler-SR1-linux-gtk.tar.gz"
	fi

	  if [ -f $eclipse_file ]; then
	    sudo tar xf $eclipse_file -C /opt &&
	    sudo mv /opt/eclipse /opt/eclipse-kepler &&
	    sudo bash -c 'cat > /usr/share/applications/eclipse-kepler.desktop <<EOF
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
EOF'
    sudo ln -s /opt/eclipse-kepler/eclipse /usr/bin/eclipse-kepler
    sudo ln -s /usr/bin/eclipse-kepler /usr/bin/eclipse
  else
    echo "$eclipse_file should be on this folder"
  fi
else
  echo "Eclipse already installed"
fi


