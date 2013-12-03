#! /bin/bash

if ! (which idea-ic-13 > /dev/null)
  then
  if [ -f ideaIC-13.tar.gz ]; then
    IDEA_PREFIX="idea-IC-13"
    echo "Unpacking"
    tar xf ideaIC-13.tar.gz &&
    find . -name "$IDEA_PREFIX*" -type d -exec mv {} $IDEA_PREFIX \; &&
    echo "Creating shortcuts"
    sudo mv $IDEA_PREFIX /opt &&
    sudo sh -c 'cat > /usr/share/applications/idea-ic-13.desktop <<EOF
[Desktop Entry]
Name=IntelliJ Idea 13 Community
Type=Application
Exec=/opt/idea-IC-13/bin/idea.sh
Terminal=false
Icon=/opt/idea-IC-13/bin/idea.png
Comment=Integrated Development Environment
NoDisplay=false
Categories=Development;IDE
Name[en]=Idea 13 Community
EOF'
    sudo ln -fs /opt/$IDEA_PREFIX/bin/idea.sh /usr/local/bin/idea-ic-13
  else 
    echo "ideaIC-13.tar.gz should be on this folder"
  fi
fi
