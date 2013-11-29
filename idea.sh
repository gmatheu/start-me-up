#! /bin/bash

if ! (which idea > /dev/null)
  then
  if [ -f ideaIC-12.1.4.tar.gz ]; then
    IDEA_PREFIX="idea-IC-12"
    tar xf ideaIC-12.1.4.tar.gz &&
    find . -name "$IDEA_PREFIX*" -type d -exec mv {} $IDEA_PREFIX \; &&
    sudo mv $IDEA_PREFIX /opt &&
    sudo -c 'cat > /usr/share/applications/idea.desktop <<EOF
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
EOF'
    sudo ln -s /opt/$IDEA_PREFIX/bin/idea.sh /usr/bin/idea
  else 
    echo "ideaIC-12.1.4.tar.gz should be on this folder"
  fi
fi
