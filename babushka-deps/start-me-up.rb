PACKAGES = %Q|
subversion aptitude tig curl autojump geany pidgin
tree htop ack-grep xclip vlc meld pass
|.split.each { |p| dep "#{p}.lib" }

BINARIES = %Q|
|.split.each { |p| dep "#{p}.bin" }

dep 'start-me-up', :home do
  home.default! '~/.start-me-up'

  PACKAGES.each  { |p| requires "#{p}.lib"}
  ['shell', 'tmux'].each do |d|
    requires d.with(home: home)
  end
  requires 'ruby', 'java', 'git', 'nodejs'
  requires 'cloud-storage', 'heroku'
  requires 'firefox'
  requires 'vagrant'
  requires 'atom', 'sublime', 'vim', 'lighttable'
  requires 'ant-downloader', 'caffeine', 'shutter'
  # requires 'docker', 'virtualbox', 'google-chrome', 'skype'
end
