#! /bin/bash

FILE='burpsuite_free_v1.5.jar'
DIR='/opt/burp'
EXEC="$DIR/$FILE"

echo "Installing Burp"
sudo mkdir --parents $DIR
if [ ! -f $EXEC ]; then
  sudo wget -O $EXEC "http://portswigger.net/burp/$FILE"
else
  echo "File already exists: $EXEC"
fi
echo "Creating shortcuts"
sudo bash -c "cat > $DIR/burp <<EOF
#! /bin/bash
java -Dsun.security.ssl.allowUnsafeRenegotiation=true -jar $EXEC &
EOF"
sudo chmod +x $DIR/burp
sudo bash -c 'cat > /usr/share/applications/burp.desktop <<EOF
[Desktop Entry]
Name=Burp Suite
Type=Application
Exec=/opt/burp/burp
Terminal=false
NoDisplay=false
Categories=Development;IDE
Name[en]=Burp Suite
EOF'
sudo ln -sf $DIR/burp /usr/local/bin/burp
echo "Done!"
