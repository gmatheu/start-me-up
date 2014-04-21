#! /bin/bash

function install-idea {
  local version=$1
  local full_version=$2
  local bin="idea-$5-$version"
  local idea_prefix="idea-$4-$version"
  local file="idea${4}-${full_version}.tar.gz"
  local version_type=$3
  echo "Installing $version $version_type"

  if ! (which $bin > /dev/null)
    then
    if [ -f $file ]; then
      echo "Unpacking..."
      tar xf $file &&
      find . -name "$idea_prefix*" -type d -exec mv {} $idea_prefix \; &&
      echo "Creating shortcuts"
      sudo mv $idea_prefix /opt &&
      sudo sh -c 'cat > /usr/share/applications/${bin}.desktop <<EOF
  [Desktop Entry]
  Name=IntelliJ Idea $version $version_type
  Type=Application
  Exec=/opt/$idea_prefix/bin/idea.sh
  Terminal=false
  Icon=/opt/$idea_prefix/bin/idea.png
  Comment=Integrated Development Environment
  NoDisplay=false
  Categories=Development;IDE
  Name[en]=Idea $version $version_type
  EOF'
      sudo ln -fs /opt/$idea_prefix/bin/idea.sh /usr/local/bin/$bin
    else 
      echo "$file should be on this folder"
    fi
  fi
}

install-idea "12" "12.1.4" "Community" "IC" "ic"
install-idea "12" "12.1.6" "Ultimate" "IU" "iu"
install-idea "13" "13.1.1" "Community" "IC" "ic"
install-idea "13" "13.1.1" "Ultimate" "IU" "iu"
