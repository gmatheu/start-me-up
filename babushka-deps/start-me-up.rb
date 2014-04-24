PACKAGES = %Q|
subversion zsh tmux aptitude git tig curl openjdk-7-source
openjdk-7-doc openjdk-7-jdk maven autojump geany pidgin
tree htop ack-grep xclip vlc meld
|.split

dep 'start-me-up' do
  requires 'ppa'.with(spec: 'ppa:git-core/ppa')
  PACKAGES.each  { |p| requires "#{p}.lib"}
  requires 'zsh shell'
  requires 'rvm'
end

PACKAGES.each { |p| dep "#{p}.lib" }

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
