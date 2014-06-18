PACKAGES = %Q|
subversion aptitude tig curl autojump geany pidgin
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
  requires 'ruby', 'java', 'git'
  requires 'cloud-storage', 'heroku'
  requires 'docker'
  requires 'atom', 'sublime', 'vim'
  requires 'ant-downloader'
end
