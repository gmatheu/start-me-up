PACKAGES = %Q|
subversion aptitude tig curl openjdk-7-source
openjdk-7-doc openjdk-7-jdk maven autojump geany pidgin
tree htop ack-grep xclip vlc meld
|.split.each { |p| dep "#{p}.lib" }

BINARIES = %Q|
|.split.each { |p| dep "#{p}.bin" }


dep 'start-me-up', :home do
  home.default! '~/.start-me-up'

  PACKAGES.each  { |p| requires "#{p}.lib"}
  ['shell', 'tmux'].each do |d|
    requires d.with(home: home)
  end
  requires 'ruby', 'git'
  requires 'copy', 'heroku'
  requires 'atom', 'sublime'
  requires 'ant-downloader'
end
