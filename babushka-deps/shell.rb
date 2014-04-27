OH_MY_ZSH_HOME = '~/.oh-my-zsh'
OH_MY_ZSH_CUSTOM = "#{OH_MY_ZSH_HOME}/custom"

dep 'shell', :home do
  requires [
    'zsh.bin',
    'zsh shell',
    ['zshrc', 'zshenv'].map { |d|
      'dot file'.with(target: d, home: home / 'dotfiles')
    },
    'oh-my-zsh',
    'zsh-syntax-highlighting'
  ].flatten
end

dep 'zsh-syntax-highlighting' do
  requires 'oh-my-zsh'
  @repo = 'https://github.com/zsh-users/zsh-syntax-highlighting.git'
  @path = "#{OH_MY_ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
  met? { Babushka::GitRepo.repo_for(@path).exists? }
  meet { git @repo, :to => @path }
end

dep 'oh-my-zsh' do
  @home = OH_MY_ZSH_HOME
  met? { @home.p.exist? }
  meet { shell `curl -L http://install.ohmyz.sh | sh` }
end

dep 'zsh shell' do
  requires 'zsh.bin'
  met? { shell("sudo su - '#{current_username}' -c 'echo $SHELL'") == which('zsh') }
  meet { sudo "chsh -s '#{which('zsh')}' #{current_username}" }
end

dep 'dot file', :target, :dest, :home do
  dest.default! '~'
  source_file = File.expand_path "#{home}/#{target}"
  dot_file = File.expand_path "#{dest}/.#{target}"

  met? { File.exists?(dot_file) && File.symlink?(dot_file) }
  meet {
    File.rename dot_file, "#{dot_file}.stu" if File.exists?(dot_file)
    File.symlink source_file, dot_file
  }
end

dep 'zsh.bin'
