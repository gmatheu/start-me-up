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
  requires 'rvm'
  requires 'git'
  requires 'copy'
end

dep 'rvm' do
  met? {
    which('rvm')
  }

  meet {
    shell 'bash -c "`curl -L https://get.rvm.io`"'
    shell 'bash -c "source ~/.rvm/scripts/rvm; rvm notes"'
    # profile = Dir["~/.bash_profile", "~/.bashrc"].first || "~/.bash_profile"
    # shell "echo 'if [[ -s \"$HOME/.rvm/scripts/rvm\" ]] ; then source \"$HOME/.rvm/scripts/rvm\" ; fi' >> #{profile}"
  }
end
