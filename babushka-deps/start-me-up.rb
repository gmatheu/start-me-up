PACKAGES = %Q|
subversion zsh tmux aptitude git tig curl openjdk-7-source
openjdk-7-doc openjdk-7-jdk maven autojump geany pidgin
tree htop ack-grep xclip vlc meld
|.split

dep 'start-me-up' do
  PACKAGES.each  { |p| requires "#{p}.lib"}
  requires 'git.managed'
  requires 'zsh shell'
  requires 'rvm'
  requires 'copy'
end

PACKAGES.each { |p| dep "#{p}.lib" }

dep 'git.managed' do
  requires 'ppa'.with('ppa:git-core/ppa')
  installs 'git'
  provides 'git >= 1.9.2'
end

dep 'zsh shell' do
  requires 'zsh.lib'
  met? { false }
  meet { sudo "chsh -s '#{which('zsh')}'"}
end

dep 'rvm' do
  met? {
   '~/.rvm/scripts/rvm'.p.file?
  }

  meet {
    shell 'bash -c "`curl -L https://get.rvm.io`"'
    shell 'bash -c "source ~/.rvm/scripts/rvm; rvm notes"'
    # profile = Dir["~/.bash_profile", "~/.bashrc"].first || "~/.bash_profile"
    # shell "echo 'if [[ -s \"$HOME/.rvm/scripts/rvm\" ]] ; then source \"$HOME/.rvm/scripts/rvm\" ; fi' >> #{profile}"
  }
end
