module BulkDepsHelpers
  def deps_for names, suffix
    names.each do |n|
      dep "#{n}.#{suffix}"
    end
  end

  def lib_for names
    deps_for names, 'lib'
  end

  def bin_for names
    deps_for names, 'bin'
  end

  def bin_dep names
    names.map {|p| "#{p}.lib" }
  end
end

Object.send :include, BulkDepsHelpers

BASE_PACKAGES = %Q|
subversion aptitude tig curl autojump geany pidgin
tree htop ack-grep xclip vlc meld pass libxml2-utils
silversearcher-ag
|.split
lib_for BASE_PACKAGES

BASE_BINARIES = %Q|
|.split.each { |p| dep "#{p}.bin" }
bin_for BASE_BINARIES

dep 'start-me-up', :home do
  home.default! '~/.start-me-up'

  requires bin_dep BASE_PACKAGES
  requires bin_dep BASE_BINARIES

  ['shell', 'tmux'].each do |d|
    requires d.with(home: home)
  end
  requires 'ruby', 'java', 'git', 'nodejs'
  requires 'cloud-storage', 'heroku'
  requires 'firefox'
  requires 'vagrant'
  requires 'atom', 'sublime', 'vim', 'lighttable', 'latex'
  requires 'ant-downloader', 'caffeine', 'shutter'
  # requires 'docker', 'virtualbox', 'google-chrome', 'skype'
end

