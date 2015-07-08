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

dep 'start-me-up-server', :home do
  home.default! '~/.start-me-up'

  requires bin_dep %Q|subversion aptitude tig curl autojump tree htop ack-grep pass libxml2-utils silversearcher-ag|.split

  ['shell', 'tmux'].each do |d|
    requires d.with(home: home)
  end
  requires 'ruby', 'git', 'vim'
end

